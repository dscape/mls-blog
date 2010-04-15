xquery version "1.0-ml" ;

import module namespace h = "helpers" at "/lib/helpers.xqy" ;
import module namespace gen = "http://ns.dscape.org/2010/generate-tree"
  at "/lib/generate-tree.xqy" ;

xdmp:set-response-content-type( "application/xhtml+xml" ),
'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">',
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title> MarkLogic Blog </title>
  <link href="/css/screen.css" media="screen" rel="stylesheet" type="text/css"/>
</head>
<body id="home">
  <div id="wrapper">
    <div id="header">
       <h1> <img border="0" alt="MarkLogic" src="img/marklogic.png"/> Blog </h1>
    </div>
    <div id="nav">
      <ul>
        <li><a href="/">Home</a></li>
      </ul>
    </div>
    <div id="content">
      <div id="subcol">
        <h2>Facets</h2>
      </div>
     
      <div id="maincol">
        <h2>New Post</h2>
        <div id="new-article">
          { if (fn:empty(xdmp:get-request-field-names()))
            then <form name="form-new-article" method="post" 
            action="new.xqy" id="form-new-article"> 
            <input type="text" name="/article/title" id="title" size="50"/>
            <textarea name="/article/body" id="body" cols="50"/><br/>
            <input type="submit" id="submit" value="Publish"/>
          </form>
            else 
              let $title  := xdmp:url-encode(xdmp:get-request-field('/article/title'))
              return if ( $title ) then
                 let $salt   := fn:substring(xdmp:md5(fn:string(fn:current-dateTime())), 1, 4)
                 let $title  := xdmp:url-encode(xdmp:get-request-field('/article/title'))
                 let $dir    := fn:replace(fn:tokenize(xs:string(fn:current-dateTime()), "T")[1], "-", "/")
                 let $path   := fn:concat("/", $dir, "/", $title[1], "-", $salt ,".xml")
                 let $xpaths := xdmp:get-request-field-names()
                   let $values := for $field in $xpaths
                     return xdmp:get-request-field($field)
                   return (xdmp:document-insert( $path,
                     gen:process-fields( $xpaths, $values ) ),
                     <p>New Post created</p>)
                     else <p>No title was supplied</p> }
        </div>
        <p>[ { h:link_to_index() } ]</p>
      </div>
    </div>
  </div>
  <div id="footer">
    <p> Copyright © 2010 Mark Logic. All rights Reserved. </p>
  </div>
</body>
</html>