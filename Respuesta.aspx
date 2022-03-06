<%@Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@Import Namespace = "System" %>

<script runat="server">
    Dim gl_Intentos As Integer

    Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)

        If Not Page.IsPostBack() Then
            'Obtiene Tipo de Solicitud
            'SP_GetSolTipo()

            'If Request.QueryString("vq_usucve") <> "" Then
            '    Buscar(Trim(Request.QueryString("vq_usucve")))
            'End If
        End If
    End Sub



</script>

<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title></title>
        <meta name="description" content="Ela Admin - HTML5 Admin Template">
            <meta name="viewport" content="width=device-width, initial-scale=1">

                <link rel="apple-touch-icon" href="https://i.imgur.com/QRAUqs9.png">
                    <link rel="shortcut icon" href="https://i.imgur.com/QRAUqs9.png">

                        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/normalize.css@8.0.0/normalize.min.css">
                            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css">
                                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">
                                    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
                                        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pixeden-stroke-7-icon@1.2.3/pe-icon-7-stroke/dist/pe-icon-7-stroke.min.css">
                                            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.2.0/css/flag-icon.min.css">
                                                <link rel="stylesheet" href="assets/css/cs-skin-elastic.css">
                                                    <link rel="stylesheet" href="assets/css/style.css">

                                                        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>

                                                            <!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
</head>
<body class="bg-red">
                    
    <div class="sufee-login d-flex align-content-center flex-wrap">
        
                <!-- Content -->
        <div class="content">

           <form id="form1" method = "post" runat="server" target="_self">

            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <strong class="card-title"></strong>
                    </div>
                    <div class="card-body">
                        <div class="row">
                        <!-- .table-stats -->
                        <table class="table ">
                            <tbody>
                                <tr>
                                    <td width="33%">
                                    </td>
                                    <td width="33%">
                                            <div class="card">
                                                <div class="card-header bg-success">
                                                  <ul class="list-group list-group-flush">
                                                        <li class="list-group-item">
                                                            <asp:HyperLink ID="HyperLink1" NavigateUrl="~/AppV_SolicitudNew.aspx" runat="server"> <i class="fa ti-close"></i> <strong class="card-title text-center">Mensaje</strong></asp:HyperLink>
                                           
                                                        </li>
                                                    </ul>
                                                </div>
                                                <div class="card-body text-white bg-light">
                                                    <p class="card-text text-black-50"> Codigo : <%= Session("codigoRespuesta")  %></p>
                                                </div>
                                            </div>

                                    </td>
                                    <td width="33%">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- /.table-stats -->
                        </div>
                    </div>
                    <!-- .card-body -->
                </div>
                <!-- .card -->
            </div>
            <!-- .col-md-12 -->

            </form>

        </div>
                          
    </div>
                        

    <script src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.4/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-match-height@0.7.2/dist/jquery.matchHeight.min.js"></script>
    <script src="assets/js/main.js"></script>

</body>
</html>
