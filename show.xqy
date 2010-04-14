xquery version "1.0-ml" ;

xdmp:set-response-content-type( "application/xhtml+xml" ),
'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">',
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta http-equiv="content-type" content="text/html; charset=utf-8" />
  <title> MarkLogic Blog </title>
  <link href="css/screen.css" media="screen" rel="stylesheet" type="text/css"/>
</head>
<body id="home">
  <div id="wrapper">
    <div id="header">
      <h1> MarkLogic Blog </h1>
    </div>
    <div id="nav">
      <ul>
        <li><a href="index.xqy">Home</a></li>
      </ul>
    </div>
    <div id="content">
      <div id="subcol">
        <h2>Facets</h2>
        Not yet
      </div>
     
      <div id="maincol">
        <div id="search">
          <form name="form-search" action="search.xqy" id="form-search">
            <input type="text" name="q" id="q" size="50"/>
            <input type="submit" id="submitbtn" value="search"/>
          </form>
        </div><br/> { 
          let $uri := xdmp:get-request-field("uri")
          let $a := doc($uri)
            return 
            (<h2>{fn:string($a//*:title)}</h2>,
            <p>{fn:string($a//*:body)}</p>) }
        <p>[ <a href="new.xqy">Add new</a> ]</p>
      </div>
    </div>
  </div>
  <div id="footer">
    <p> Copyright © 2010 Mark Logic. All rights Reserved. </p>
  </div>
</body>
</html>
