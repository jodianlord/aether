<%@page import="javax.servlet.http.*"%>

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
        <link rel="stylesheet" type="text/css" href="css/jquery-confirm.css">

        <style type="text/css">
            body {
                height: 100%;
                margin: 0;
                padding: 0;
                width: 100%;
                height: 100%;
                max-height: 100%;
                margin: 0;
                padding: 0;
                background-image: url("img/bg1.png");
                background-size:100% 100%;
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
                                <form action="LoginServlet" method="post">
                                    <div class="field-wrap">
                                        <label>
                                            Username<span class="req">*</span>
                                        </label>
                                        <input type="text" name='userid' required autocomplete="off"/>
                                    </div>

                                    <div class="field-wrap">
                                        <label>
                                            Password<span class="req">*</span>
                                        </label>
                                        <input type="password" name='password' required autocomplete="off"/>
                                    </div>

                                    <p class="forgot"><a href="#">Forgot Password?</a></p>

                                    <div class="field-wrap"> <!-- <div class="field-wrap"> -->
                                        <label style="margin-top:2.3%">
                                            Group ID
                                        </label> 

                                        <br>
                                        <div class="field-wrap" style="margin-left:18%">  
                                            <select id="groupid" name="groupid" required autocomplete="off">
                                                <option value= null selected> No Group </option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                                <option value="9">9</option>
                                            </select>
                                        </div>                                           
                                    </div>
                                    <br> 

                                    <button class="button button-block"/>LOG IN</button>
                                </form>
                            </div>


                            <div id="signup">   
                                <!--<form>-->
                                <form id="SignUpForm" action="SignUpServlet" method="post">
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

                                    <!--                                    <div class="field-wrap">
                                                                            <label>
                                                                                Private Key<span class="req">*</span>
                                                                            </label>
                                                                            <input type="text" name='privatekey' required autocomplete="off"/>
                                                                        </div>-->

                                    <button type="submit" id="signupbutton" class="button button-block"/>SIGN UP</button>
                                    <!--                                <div id="other">
                                                                        Trigger the handler
                                                                    </div>-->
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
        <script src='js/jquery-1.8.3.min.js'></script>
        <script src="js/jquery-confirm.js"></script>
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

    <script>


        $("#signupbutton").click(function (event) {
            event.preventDefault();
            $.confirm({
                title: 'Sign Up!',
                content: 'Are you sure you want to Sign Up?',
                columnClass: 'col-md-4 col-md-offset-4',
                buttons: {
                    confirm: function () {
                        $("#SignUpForm").submit();
    </script>
    <%
        String userError = (String) session.getAttribute("userError");
        System.out.println("userError is");
        System.out.println(userError);
        if (userError == "exist") {
            session.removeAttribute("userError");

    %>
    <script>
                        $.confirm({
                            title: 'User Exists!',
                            content: 'User already exists! Please try again using a different User ID.',
                            columnClass: 'col-md-4 col-md-offset-4',
                            buttons: {
                                confirm: function () {

                                },
                                cancel: function () {
                                    //                            $.alert('Sign Up Failed!');
                                    //                            return false;
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
    <%
            } else {
        session.removeAttribute("userError");
    %>

    <script>
                        $.confirm({
                            title: 'Account Creation Successful!',
                            content: 'Your account has been successfully created! You can now log in using your credentials.',
                            columnClass: 'col-md-4 col-md-offset-4',
                            buttons: {
                                confirm: function () {

                                },
                                cancel: function () {
                                    //                            $.alert('Sign Up Failed!');
                                    //                            return false;
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


                    },
                    cancel: function () {
                        //                            $.alert('Sign Up Failed!');
                        //                            return false;
                    }
                }
            });
        });


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
    <%
        }

        session.invalidate();
    %>

</body>
</html>