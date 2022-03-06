<%@Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@Import Namespace = "System" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace = "System.Data" %>
<%@Import Namespace = "System.Data.OleDb" %>
<%@Import Namespace = "System.Data.SqlClient" %>

<script runat="server">
    'Variables de Permisos
    Dim Vg_mod1 As Integer
    Dim Vg_mod2 As Integer
    Dim Vg_mod3 As Integer
    Dim Vg_mod4 As Integer
    Dim Vg_mod5 As Integer
    Dim Vg_mod6 As Integer
    Dim Vg_mod7 As Integer
    Dim Vg_mod8 As Integer
    Dim Vg_mod9 As Integer
    Dim Vg_mod10 As Integer

    Dim Vg_Fac1 As Integer
    Dim Vg_Fac2 As Integer
    Dim Vg_Fac3 As Integer
    Dim Vg_Fac4 As Integer
    Dim Vg_Fac5 As Integer
    Dim Vg_Fac6 As Integer
    Dim Vg_Fac7 As Integer
    Dim Vg_Fac8 As Integer
    Dim Vg_Fac9 As Integer
    Dim Vg_Fac10 As Integer

    Public vg_Name As String
    Public vg_LastName As String

    Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If Not Session("UsuAppV") <> "" Then
            Response.Write("<script>window.open('portal.aspx',target='_self');<" & "/" & "script>")
        End If
        'Dim dsColumnas As New DataSet
        ' SP_GetPermiso()
        If Not Page.IsPostBack() Then
            'Obtiene Tipo de Vuelo
            'SP_GetTipoVuelo()
            'Obtienes Secretarias
            'SP_GetSecretarias()
            'Clean Campos
            'CleanFields()
            'SP_GetSolicitudxFiltro()
            'If Not Session("vp_UsuCve") <> "" Then
            '    MsgBox("No puedes estar aqui", MsgBoxStyle.Exclamation, "iDocumental")
            'End If
            'If Request.QueryString("vq_usucve") <> "" Then
            '    Buscar(Trim(Request.QueryString("vq_usucve")))
            'End If
        End If
    End Sub



    Protected Sub Alert(codigo As String)

        Response.Write("<script>window.alert('" & codigo & "');<" & "/" & "script>")

    End Sub



    Protected Sub GV_Pasajero_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Try
            If (e.Row.RowType = DataControlRowType.Header) Then
                e.Row.Cells(1).Visible = False
                e.Row.Cells(4).Visible = False
                e.Row.Cells(5).Visible = False
                e.Row.Cells(6).Visible = False
                e.Row.Cells(7).Visible = False
                e.Row.Cells(8).Visible = False
                e.Row.Cells(9).Visible = False
                e.Row.Cells(10).Visible = False
                e.Row.Cells(11).Visible = False
                e.Row.Cells(12).Visible = False
                e.Row.Cells(13).Visible = False
                e.Row.Cells(17).Visible = False
                e.Row.Cells(19).Visible = False
                e.Row.Cells(20).Visible = False
                e.Row.Cells(21).Visible = False
                e.Row.Cells(22).Visible = False
                e.Row.Cells(23).Visible = False
                e.Row.Cells(24).Visible = False
                e.Row.Cells(25).Visible = False
                e.Row.Cells(26).Visible = False
                e.Row.Cells(27).Visible = False
                e.Row.Cells(28).Visible = False
                e.Row.Cells(29).Visible = False
                e.Row.Cells(30).Visible = False
                e.Row.Cells(31).Visible = False
                e.Row.Cells(32).Visible = False
                e.Row.Cells(2).Font.Size = 10
                e.Row.Cells(3).Font.Size = 10
                e.Row.Cells(14).Font.Size = 10
                e.Row.Cells(15).Font.Size = 10
                e.Row.Cells(16).Font.Size = 10
                e.Row.Cells(18).Font.Size = 10
                e.Row.Cells(2).Text = "CLAVE"
                e.Row.Cells(3).Text = "ORIGEN"
                e.Row.Cells(14).Text = "NOMBRE"
                e.Row.Cells(15).Text = "PATERNO"
                e.Row.Cells(16).Text = "MATERNO"
                e.Row.Cells(18).Text = "SECRETARIA"
            End If
            If (e.Row.RowType = DataControlRowType.DataRow) Then
                e.Row.Cells(1).Visible = False
                'e.Row.Cells(3).Visible = False
                e.Row.Cells(4).Visible = False
                e.Row.Cells(5).Visible = False
                e.Row.Cells(6).Visible = False
                e.Row.Cells(7).Visible = False
                e.Row.Cells(8).Visible = False
                e.Row.Cells(9).Visible = False
                e.Row.Cells(10).Visible = False
                e.Row.Cells(11).Visible = False
                e.Row.Cells(12).Visible = False
                e.Row.Cells(13).Visible = False
                e.Row.Cells(17).Visible = False
                e.Row.Cells(19).Visible = False
                e.Row.Cells(20).Visible = False
                e.Row.Cells(21).Visible = False
                e.Row.Cells(22).Visible = False
                e.Row.Cells(23).Visible = False
                e.Row.Cells(24).Visible = False
                e.Row.Cells(25).Visible = False
                e.Row.Cells(26).Visible = False
                e.Row.Cells(27).Visible = False
                e.Row.Cells(28).Visible = False
                e.Row.Cells(29).Visible = False
                e.Row.Cells(30).Visible = False
                e.Row.Cells(31).Visible = False
                e.Row.Cells(32).Visible = False
                e.Row.Cells(2).Font.Size = 10
                e.Row.Cells(3).Font.Size = 10
                e.Row.Cells(14).Font.Size = 10
                e.Row.Cells(15).Font.Size = 10
                e.Row.Cells(16).Font.Size = 10
                e.Row.Cells(18).Font.Size = 10
            End If

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

</script>

<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="">
 <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>App Vuelos</title>
    <meta name="description" content="Aplicacion de Vuelos">
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
    <!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
    <link href="https://cdn.jsdelivr.net/npm/chartist@0.11.0/dist/chartist.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/jqvmap@1.5.1/dist/jqvmap.min.css" rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/weathericons@2.1.0/css/weather-icons.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@3.9.0/dist/fullcalendar.min.css" rel="stylesheet" />

    <style>
        #weatherWidget .currentDesc {
            color: #ffffff !important;
        }

        .traffic-chart {
            min-height: 335px;
        }

        #flotPie1 {
            height: 150px;
        }

            #flotPie1 td {
                padding: 3px;
            }

            #flotPie1 table {
                top: 20px !important;
                right: -10px !important;
            }

        .chart-container {
            display: table;
            min-width: 270px;
            text-align: left;
            padding-top: 10px;
            padding-bottom: 10px;
        }

        #flotLine5 {
            height: 105px;
        }

        #flotBarChart {
            height: 150px;
        }

        #cellPaiChart {
            height: 160px;
        }
    </style>
</head>

<body oncontextmenu="return false" >
    <div id="right-panel" class="right-panel">
        <!-- Header-->
        <header id="header" class="header">
            <div class="top-left">
                <div class="navbar-header">
                    <a class="navbar-brand" href="portal.aspx"><img src="images/logo.png" alt="Logo"></a>
                    <a class="navbar-brand hidden" href="portal.aspx"><img src="images/logo2.png" alt="Logo"></a>
                    <a id="menuToggle" class="menutoggle"><i class="fa fa-bars"></i></a>

                </div>
            </div>

            <div class="top-right">
                <div class="header-menu">
                    <div class="user-area dropdown float-right">
                        <a href="#" class="dropdown-toggle active" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img class="user-avatar rounded-circle" src="images/user.png" alt="User Avatar">
                        </a>

                        <div class="user-menu dropdown-menu">
                            <a class="nav-link"><i class="fa fa- user"></i><%=vg_Name & " " & vg_LastName  %></a>
                            <a class="nav-link" href="./miperfil.aspx"><i class="fa fa- user"></i>Mi Perfil</a>
                            <a class="nav-link" href="./" onclick="<script> self.close(); </script>"><i class="fa fa-power -off"></i>Logout</a>
                        </div>
                    </div>

                </div>
            </div>
        </header>
        <!-- /#header -->
        <!-- Content -->
        <div class="content">
        <div>
            <img src="images/pagina-en-construcción1.jpg" class="img-fluid" alt="Responsive image">
        </div>
           
        </div>
        <!-- /.content -->
        <div class="clearfix"></div>
        <!-- Footer -->
        <footer class="site-footer">
            <div class="footer-inner bg-white">
                <div class="row">
                    <div class="col-sm-4 text-left">
                        Copyright &copy; 2018 Empresa
                    </div>
                    <div class="col-sm-4 text-center">
                        <i class="fa fa-envelope"></i>
                        <asp:HyperLink ID="HyperLink16" NavigateUrl ="contactanos.aspx" runat="server">Contactanos</asp:HyperLink>
                    </div>
                    <div class="col-sm-4 text-right">
                        Designed by <a href="smart.cen-pri.mx">Empresa</a>
                    </div>
                </div>
            </div>
        </footer>
        <!-- /.site-footer -->
    </div>
    <!-- /#right-panel -->
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.4/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-match-height@0.7.2/dist/jquery.matchHeight.min.js"></script>
    <script src="assets/js/main.js"></script>

    <!--  Chart js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.7.3/dist/Chart.bundle.min.js"></script>

    <!--Chartist Chart-->
    <script src="https://cdn.jsdelivr.net/npm/chartist@0.11.0/dist/chartist.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartist-plugin-legend@0.6.2/chartist-plugin-legend.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/jquery.flot@0.8.3/jquery.flot.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flot-pie@1.0.0/src/jquery.flot.pie.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flot-spline@0.0.1/js/jquery.flot.spline.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/simpleweather@3.1.0/jquery.simpleWeather.min.js"></script>
    <script src="assets/js/init/weather-init.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/moment@2.22.2/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@3.9.0/dist/fullcalendar.min.js"></script>
    <script src="assets/js/init/fullcalendar-init.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
     <script src="js/Vuelos.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //$('#bootstrap-data-table-export').DataTable();
            $('#GV_Pasajero').on('click', 'tr td', function (evt) {
                var codigo = $(this).parents("tr").find("td").eq(1).text();
                $("#claveSol").val(codigo);
                $("#hdName").val(getValue);
                descarga(codigo);

            });

            $("#ShowMens").click(function () {
                $('form').submit(function (event) {
                    event.preventDefault();

                });
                cancelSolicitud();
            });

            function cancelSolicitud() {

                (async () => {

                    const { value: text } = await Swal.fire({
                        input: 'textarea',
                        inputLabel: 'Cancelar Solicitud',
                        inputPlaceholder: 'Motivo de la cancelacion...',
                        inputAttributes: {
                            'aria-label': ''
                        },
                        showCancelButton: true
                    })

                    if (text) {
                        //string codeEvento, string motivoCancelacion
                        //VuelosService.aspx/CancelarSolicitud
                        $.ajax({
                            type: "POST",
                            url: "VuelosService.aspx/CancelarSolicitud",
                            data: '{codeEvento: "' + $('#Text_Clave').val() + '",' + ' motivoCancelacion: "' + text + '"  }',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (r) {
                                Swal.fire("La solicitud a sido cancelada");
                                location.reload();
                            }
                        });
                        
                    }

                })()
            };
        });
    </script>
</body>
</html>
