<?php

    $error = ""; $successMessage = "";

    if ($_POST) {
        
        if (!$_POST["email"]) {
            
            $error .= "Wir benötigen Ihre Email Adresse.<br>";
            
        }
        
        if (!$_POST["content"]) {
            
            $error .= "Wir benötigen Ihre Nachricht.<br>";
            
        }
        
        if (!$_POST["subject"]) {
            
            $error .= "Wir benötigen einen Betreff.<br>";
            
        }
        
        if ($_POST['email'] && filter_var($_POST["email"], FILTER_VALIDATE_EMAIL) === false) {
            
            $error .= "Die Email Adresse ist nicht gültig.<br>";
            
        }
        
        if ($error != "") {
            
            $error = '<div class="alert alert-danger" role="alert"><p>Es sind Fehler in Ihrem Formular aufgetreten:</p>' . $error . '</div>';
            
        } else {
            
            $emailTo = "me@mydomain.com";
            
            $subject = $_POST['subject'];
            
            $content = $_POST['content'];
            
            $headers = "From: ".$_POST['email'];
            
            if (mail($emailTo, $subject, $content, $headers)) {
                
                $successMessage = '<div class="alert alert-success" role="alert">Ihre Nachricht wurde an uns übermittelt. Wir kommen so schnell es geht wieder auf Sie zu!</div>';
                
                
            } else {
                
                $error = '<div class="alert alert-danger" role="alert"><p><strong>Ihre Nachricht konnte nicht gesendet werden. Bitte versuchen Sie es noch einmal.</div>';
                  
            }
            
        }
         
    }

?>

<!DOCTYPE html>

<html lang="en">
    
  <head>
    
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.2/css/bootstrap.min.css" integrity="sha384-y3tfxAZXuh4HwSYylfB+J125MxIs6mR5FOHamPBG064zB+AFeWH94NdvaCBm8qnd" crossorigin="anonymous">
      
    <style>
      
        .container {
            
            margin-top: 80px;
            width: 50%;
            
        }
      
    </style>
      
  </head>
    
  <body>
      
      <nav class="navbar navbar-light bg-faded navbar-fixed-top" id="navbar">
            
          <a class="navbar-brand" href="#" id="logo">BuyVision</a>
            
          <ul class="nav navbar-nav">
            <li class="nav-item">
              <a class="nav-link" href="#jumbotron">Startseite <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#about">Über BuyVision</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#footer">Die App downloaden</a>
            </li>
          </ul>
            
          <form class="form-inline pull-xs-right">
            <input class="form-control" type="email" placeholder="Email" style="width:240px">
            <input class="form-control" type="password" placeholder="Passwort" style="width:240px">
            <button class="btn btn-success" type="submit">Login</button>
          </form>
            
        </nav>
      
      <div class="container">
      
            <h1>Kontakt</h1>

              <div id="error"><? echo $error.$successMessage; ?></div>

              <form method="post">

                  <fieldset class="form-group">
                    <label for="email">Email Adresse</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Bitte geben Sie Ihre Email Adresse ein">
                  </fieldset>
                  <fieldset class="form-group">
                    <label for="subject">Betreff</label>
                    <input type="text" class="form-control" id="subject" name="subject" >
                  </fieldset>
                  <fieldset class="form-group">
                    <label for="exampleTextarea">Was möchten Sie uns mitteilen?</label>
                    <textarea class="form-control" id="content" name="content" rows="10"></textarea>
                  </fieldset>
                  <button type="submit" id="submit" class="btn btn-primary">Abschicken</button>

              </form>
          
        </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.2/js/bootstrap.min.js" integrity="sha384-vZ2WRJMwsjRMW/8U7i6PWi6AlO1L79snBrmgiDpgIWJ82z8eA5lenwvxbMV1PAh7" crossorigin="anonymous"></script>
          
    <script type="text/javascript">
          
          $("form").submit(function(e) {
              
              var error = "";
              
              if ($("#email").val() == "") {
                  
                  error += "Wir benötigen Ihre Email Adresse.<br>"
                  
              }
              
              if ($("#subject").val() == "") {
                  
                  error += "Wir benötigen einen Betreff.<br>"
                  
              }
              
              if ($("#content").val() == "") {
                  
                  error += "Wir benötoigen Ihre Nachricht.<br>"
                  
              }
              
              if (error != "") {
                  
                 $("#error").html('<div class="alert alert-danger" role="alert"><p><strong>Es sind Fehler in Ihrem Formular aufgetreten:</strong></p>' + error + '</div>');
                  
                  return false;
                  
              } else {
                  
                  return true;
                  
              }
          })
          
    </script>
          
  </body>
