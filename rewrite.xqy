(:
 : removing the fallback
 :)
declare function local:get-uri-encoded-fields() {
  let $fields := fn:string-join( for $field in xdmp:get-request-field-names()
    return fn:concat( $field, "=", 
      xdmp:url-encode(xdmp:get-request-field( $field ) ) ), "&amp;" )
  return if ($fields) then fn:concat("?", $fields) else "" } ; 

declare function local:default( $path ) {
  fn:concat( $path, local:get-uri-encoded-fields() ) } ;
declare function local:requested-root ( $path ) { fn:matches($path, "^/$") } ;
declare function local:requested-new-article ( $path ) { 
  fn:matches($path, "^/article$") } ;
declare function local:requested-show-article ( $path ) { 
  fn:matches($path, "^/article/\.*") } ;

declare function local:show( $path ) {
   fn:concat( "show.xqy?uri=/", fn:replace($path, "^/article/(\.*)", "$2") ) };

let $path := xdmp:get-request-path()
  return 
    if ( local:requested-root ( $path ) )
    then "index.xqy"
    else 
      if ( local:requested-new-article ( $path ) )
      then fn:concat( "new.xqy", local:get-uri-encoded-fields() )
      else 
        if ( local:requested-show-article ( $path ) )
        then local:show( $path )
        else "404.xqy"