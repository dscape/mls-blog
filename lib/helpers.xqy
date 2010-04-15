xquery version "1.0-ml";

module namespace h = "helpers";

declare function h:link_to_index() {
  <a href="/" xmlns="http://www.w3.org/1999/xhtml">Back to main</a> } ;

declare function h:link_to_new() {
  <a href="/new" xmlns="http://www.w3.org/1999/xhtml">Add new</a> } ;

declare function h:link_to_show( $path ) {
  fn:concat( '/show', $path ) }; 