<!DOCTYPE html>
<html lang="en" class="no-js">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <title>Aether</title>



        <link rel="stylesheet" type="text/css" href="css/normalize.css" />
        <link rel="stylesheet" type="text/css" href="css/loginbox.css" />
        <link href='https://fonts.googleapis.com/css?family=Abel' rel='stylesheet'>

        <style type="text/css">
            body{
                background-image: url("img/bg1.png");
                background-repeat: no-repeat;
            }
        </style>







    </head>
    <body>
        <div class="container demo-1">
            <div class="content">
                <div id="large-header" class="large-header">
                    <canvas id="demo-canvas"></canvas>

                    <div class="form">
                        <img height="150" width="285" src="img/aetherlogo_white.png" style="margin-left: 23%;margin-top: -5%;">
                        <ul class="tab-group">
                            <li class="tab active"><a href="#login">Log In</a></li>
                            <li class="tab"><a href="#signup">Sign Up</a></li>
                        </ul>

                        <div class="tab-content">
                            
                            <div id="login">   
                                <form action="/" method="post">
                                    <div class="field-wrap">
                                        <label>
                                            Email Address<span class="req">*</span>
                                        </label>
                                        <input type="email"required autocomplete="off"/>
                                    </div>

                                    <div class="field-wrap">
                                        <label>
                                            Password<span class="req">*</span>
                                        </label>
                                        <input type="password"required autocomplete="off"/>
                                    </div>

                                    <p class="forgot"><a href="#">Forgot Password?</a></p>

                                    <button class="button button-block"/>LOG IN</button>
                                </form>
                            </div>
                            
                            
                            <div id="signup">   
                                <form action="SignUpServlet" method="post">
                                    <div class="top-row">
                                        <div class="field-wrap">
                                            <label>
                                                User ID<span class="req">*</span>
                                            </label>
                                            <input type="text" name='userid' required autocomplete="off" />
                                        </div>

                                        <div class="field-wrap">
                                            <label>
                                                Password<span class="req">*</span>
                                            </label>
                                            <input type="password" name='password' required autocomplete="off"/>
                                        </div>
                                    </div>

                                    <div class="field-wrap">
                                        <label>
                                            Public Key<span class="req">*</span>
                                        </label>
                                        <input type="text" name='publickey' required autocomplete="off"/>
                                    </div>

                                    <div class="field-wrap">
                                        <label>
                                            Private Key<span class="req">*</span>
                                        </label>
                                        <input type="text" name='privatekey' required autocomplete="off"/>
                                    </div>

                                    <button type="submit" class="button button-block"/>SIGN UP</button>
                                </form>
                            </div>
                        </div><!-- tab-content -->
                    </div> 
                </div>
            </div>
        </div><!-- /container -->
        <script src="js/TweenLite.min.js"></script>
        <script src="js/EasePack.min.js"></script>
        <script src="js/demo-1.js"></script>
        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
        <script>
            $('.form').find('input, textarea').on('keyup blur focus', function (e) {

                var $this = $(this),
                        label = $this.prev('label');

                if (e.type === 'keyup') {
                    if ($this.val() === '') {
                        label.removeClass('active highlight');
                    } else {
                        label.addClass('active highlight');
                    }
                } else if (e.type === 'blur') {
                    if ($this.val() === '') {
                        label.removeClass('active highlight');
                    } else {
                        label.removeClass('highlight');
                    }
                } else if (e.type === 'focus') {

                    if ($this.val() === '') {
                        label.removeClass('highlight');
                    } else if ($this.val() !== '') {
                        label.addClass('highlight');
                    }
                }

            });

            $('.tab a').on('click', function (e) {

                e.preventDefault();

                $(this).parent().addClass('active');
                $(this).parent().siblings().removeClass('active');

                target = $(this).attr('href');

                $('.tab-content > div').not(target).hide();

                $(target).fadeIn(600);

            });
        </script>
    </body>
</html>