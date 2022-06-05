<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Admin_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Ban nông thôn mới Hà Nội</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta content="CheckVN - Ban nông thôn mới Hà Nội !" name="description" />
    <meta content="" name="author" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <!-- App favicon -->
    <link rel="shortcut icon" href="/favicons/logo.ico">
    <!-- App css -->
    <link href="/theme/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/theme/assets/css/jquery-ui.min.css" rel="stylesheet">
    <link href="/theme/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <link href="/theme/assets/css/metisMenu.min.css" rel="stylesheet" type="text/css" />
    <link href="/theme/assets/css/app.min.css" rel="stylesheet" type="text/css" />
    <style>
        .account-body.accountbg {
            background-image: url(/images/bg.jpg);
            background-repeat: no-repeat;
            background-position: center;
            background-size: cover;
        }

        .account-body .auth-card .auth-logo-text h4 {
            font-size: 20px;
            line-height: 30px;
        }
    </style>
</head>
<body class="account-body accountbg">
    <!-- Log In page -->
    <div class="container">
        <div class="row vh-100 ">
            <div class="col-12 align-self-center">
                <div class="auth-page">
                    <div class="card auth-card shadow-lg">
                        <div class="card-body">

                            <div id="Login" runat="server">
                                <div class="px-3">
                                    <div class="auth-logo-box">
                                        <a class="logo logo-admin">
                                            <img src="/assets/images/logo.png?v=2" height="55" alt="logo" class="auth-logo"></a>
                                    </div>
                                    <!--end auth-logo-box-->

                                    <div class="text-center auth-logo-text">
                                        <h4 class="mt-0 mb-3 mt-5">VĂN PHÒNG ĐIỀU PHỐI CHƯƠNG TRÌNH XÂY DỰNG BAN NÔNG THÔN MỚI HÀ NỘI</h4>
                                        <p class="text-muted mb-0">Đăng nhập để vào hệ thống.</p>
                                    </div>
                                    <!--end auth-logo-text-->


                                    <form class="form-horizontal auth-form my-4" action="index.html">

                                        <div class="form-group">
                                            <label for="username">Tài khoản</label>
                                            <div class="input-group mb-3">
                                                <span class="auth-form-icon">
                                                    <i class="dripicons-user"></i>
                                                </span>
                                                <input type="text" class="form-control" id="username">
                                            </div>
                                        </div>
                                        <!--end form-group-->

                                        <div class="form-group">
                                            <label for="userpassword">Mật khẩu</label>
                                            <div class="input-group mb-3">
                                                <span class="auth-form-icon">
                                                    <i class="dripicons-lock"></i>
                                                </span>
                                                <input type="password" class="form-control" id="userpassword">
                                            </div>
                                        </div>
                                        <!--end form-group-->
                                        <!--end form-group-->

                                        <div class="form-group mb-0 row">
                                            <div class="col-12 mt-2">
                                                <button class="btn btn-gradient-primary btn-round btn-block waves-effect waves-light" id="btnLogin" type="button" onclick="CheckLogin()">Log In <i class="fas fa-sign-in-alt ml-1"></i></button>
                                            </div>
                                            <!--end col-->
                                        </div>

                                        <!--end form-group-->
                                    </form>

                                    <!--end form-->
                                </div>
                                <!--end /div-->

                                <div class="m-3 text-center text-muted">
                                    <p class="">
                                        <a href="http://hn.eocop.vn" class="text-primary mr-2"><i class="fas fa-sign-in-alt ml-1 mr-2"></i>Đăng nhập hệ thống quản lý sản phẩm OCOP</a>
                                        <br />
                                        <a href="/" class="text-primary mr-2"><i class="fas fa-sign-in-alt ml-1 mr-2" style="transform: rotate(180deg);"></i>Quay lại trang chủ</a>
                                    </p>
                                </div>
                            </div>

                        </div>
                        <!--end card-body-->
                    </div>
                    <!--end card-->
                    <!--end account-social-->
                </div>
                <!--end auth-page-->
            </div>
            <!--end col-->
        </div>
        <!--end row-->
    </div>
    <!--end container-->
    <!-- End Log In page -->
    <!-- jQuery  -->
    <script src="/theme/assets/js/jquery.min.js"></script>
    <script src="/theme/assets/js/jquery-ui.min.js"></script>
    <script src="/theme/assets/js/bootstrap.bundle.min.js"></script>
    <script src="/theme/assets/js/metismenu.min.js"></script>
    <script src="/theme/assets/js/waves.js"></script>
    <script src="/theme/assets/js/feather.min.js"></script>
    <script src="/theme/assets/js/jquery.slimscroll.min.js"></script>
    <script>
        $("#userpassword").keyup(function (event) {
            if (event.keyCode === 13) {
                $("#btnLogin").click();
            }
        });
        $("#username").keyup(function (event) {
            if (event.keyCode === 13) {
                $("#btnLogin").click();
            }
        });
    </script>
    <script src="/js/izitoast/js/iziToast.min.js"></script>
    <link href="/js/izitoast/css/iziToast.min.css" rel="stylesheet" type="text/css" />
    <link href="/css/site.css?v=<%=Systemconstants.Version(5) %>" rel="stylesheet" type="text/css" />
    <script src="/js/global.js"></script>
    <%--<script src="/js/md5.js"></script>--%>
    <script src="/WebServices/Controller/login.js?v=<%=Systemconstants.Version(5) %>"></script>
    <script src="/js/Function.js"></script>
    <!-- App js -->
    <%--<script src="/theme/assets/js/app.js"></script>--%>
    <div id="spinner" class="spinner" style="display: none;">
        <p class="textload">Hệ thống đang đăng nhập, vui lòng đợi !!!</p>
        <img src="/assets/images/logo.png?v=2" class="img-load" />
    </div>
</body>
</html>
