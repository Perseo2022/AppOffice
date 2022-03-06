<%@Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@Import Namespace = "System" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace = "System.Data" %>
<%@Import Namespace = "System.Data.OleDb" %>
<%@Import Namespace = "System.Data.SqlClient" %>


<script runat="server">
    Dim vg_Name As String = ""
    Dim vg_LastName As String = ""

    Dim vg_xValidar As String = "0"
    Dim vg_xAprobar As String = "0"
    Dim vg_xAprobarRM As String = "0"
    Dim vg_xSurtir As String = "0"
    Dim vg_xVoBo As String = "0"
    Dim vg_xRechazar As String = "0"

    Dim vg_Total As Integer = 0
    Dim vg_TotxValidar As Double = 0.0
    Dim vg_TotxAprobarRM As Double = 0.0
    Dim vg_TotxSurtir As Double = 0.0
    Dim vg_TotxAprobar As Double = 0.0
    Dim vg_TotVoBo As Double = 0.0
    Dim vg_TotRechazadas As Double = 0.0

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


    Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Dim dsColumnas As New DataSet
        If Not Page.IsPostBack() Then
            SP_GetPermiso()
            'Obtiene Tipo de Solicitud
            ISP_GetISolInsumosxTipo()

            Session("Vs_Clave") = ""
            Session("Vs_ClaveTexto") = ""
            Session("Vs_Secretaria") = ""
            Session("Vs_TraeCve") = 0

            'If Not Session("vp_UsuCve") <> "" Then
            '    MsgBox("No puedes estar aqui", MsgBoxStyle.Exclamation, "iDocumental")
            'End If
            'If Request.QueryString("vq_usucve") <> "" Then
            '    Buscar(Trim(Request.QueryString("vq_usucve")))
            'End If
        End If
    End Sub

    Sub SP_GetPermiso()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "App_SPGetPermisoByUser"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        'Parámetros si hubieran
        Dim miParam As New SqlParameter("@UsuAppV", SqlDbType.VarChar)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        coDetalle.Parameters("@UsuAppV").Value = Session("UsuAppV")

        Dim miParam1 As New SqlParameter("@IdApp", SqlDbType.Int)
        miParam1.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam1)
        coDetalle.Parameters("@IdApp").Value = 2

        Dim miParam2 As New SqlParameter("@IdModulo", SqlDbType.Int)
        miParam2.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam2)
        coDetalle.Parameters("@IdModulo").Value = 1

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        While registro.Read
            vg_Name = registro("Usu_Nombre").ToString
            vg_LastName = registro("Usu_ApPaterno").ToString

            Select Case CInt(registro("Mod_Clave").ToString)
                Case 1
                    Vg_mod1 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac1 = CInt(registro("Fac_Clave").ToString)
                Case 2
                    Vg_mod2 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac2 = CInt(registro("Fac_Clave").ToString)
                Case 3
                    Vg_mod3 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac3 = CInt(registro("Fac_Clave").ToString)
                Case 4
                    Vg_mod4 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac4 = CInt(registro("Fac_Clave").ToString)
                Case 5
                    Vg_mod5 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac5 = CInt(registro("Fac_Clave").ToString)
                Case 6
                    Vg_mod6 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac6 = CInt(registro("Fac_Clave").ToString)
                Case 7
                    Vg_mod7 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac7 = CInt(registro("Fac_Clave").ToString)
                Case 8
                    Vg_mod8 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac8 = CInt(registro("Fac_Clave").ToString)
                Case 9
                    Vg_mod9 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac9 = CInt(registro("Fac_Clave").ToString)
                Case 10
                    Vg_mod10 = CInt(registro("Mod_Clave").ToString)
                    Vg_Fac10 = CInt(registro("Fac_Clave").ToString)
            End Select

        End While

        registro.Close()
        myConnection.Close()

    End Sub

    'Sub AbreExcel()
    '    Microsoft.Office.Interop.Excel.Application oXL;
    '    Microsoft.Office.Interop.Excel._Workbook oWB;
    '    Microsoft.Office.Interop.Excel._Worksheet oSheet;
    '    oXL = New Application();
    '    oXL.Visible = True;
    '    oWB = oXL.Workbooks.Open("c:ArchivosExcel eporte.xlsx"); //ESTA LINEA MARCA Error
    '    oSheet = (Microsoft.Office.Interop.Excel._Worksheet)oWB.ActiveSheet;
    '    //Para insertar la nota al final del archivo
    '    oSheet.Cells[1,oSheet.Rows.Count+1] = "Esta es una nota";
    '    oWB.Save();//Para salvar el archivo con la nota
    '    oWB.Close(null, null, null);
    '    oXL.Workbooks.Close();
    '    oXL.Quit();
    'End Sub

    Sub ISP_GetISolInsumosxTipo()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppI_SPGetISolInsumosxTipo"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        Dim miParam As New SqlParameter("@UsuAppV", SqlDbType.VarChar)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        coDetalle.Parameters("@UsuAppV").Value = Session("UsuAppV")

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        While registro.Read

            Select Case registro("ISot_Clave").ToString
                Case "1"
                    vg_xValidar = registro("Total").ToString
                Case "2"
                    vg_xAprobar = registro("Total").ToString
                Case "3"
                    vg_xAprobarRM = registro("Total").ToString
                Case "4"
                    vg_xSurtir = registro("Total").ToString
                Case "5"
                    vg_xVoBo = registro("Total").ToString
                Case "6"
                    vg_xRechazar = registro("Total").ToString

            End Select

            vg_Total = vg_Total + CInt(registro("Total").ToString)

        End While

        If vg_Total > 0 Then
            vg_TotxValidar = (CInt(vg_xValidar) * 100) / (vg_Total)
        Else
            vg_TotxValidar = 0
        End If
        If vg_Total > 0 Then
            vg_TotxAprobarRM = (CInt(vg_xAprobar) * 100) / (vg_Total)
        Else
            vg_TotxAprobarRM = 0
        End If
        If vg_Total > 0 Then
            vg_TotxAprobar = (CInt(vg_xAprobarRM) * 100) / (vg_Total)
        Else
            vg_TotxAprobar = 0
        End If
        If vg_Total > 0 Then
            vg_TotxSurtir = (CInt(vg_xSurtir) * 100) / (vg_Total)
        Else
            vg_TotxSurtir = 0
        End If
        If vg_Total > 0 Then
            vg_TotVoBo = (CInt(vg_xVoBo) * 100) / (vg_Total)
        Else
            vg_TotVoBo = 0
        End If

        If vg_Total > 0 Then
            vg_TotRechazadas = (CInt(vg_xRechazar) * 100) / (vg_Total)
        Else
            vg_TotRechazadas = 0
        End If

        registro.Close()
        myConnection.Close()

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
    <title>App Insumos</title>
    <meta name="description" content="Aplicacion de Insumos">
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
        color: #ffffff!important;
    }
        .traffic-chart {
            min-height: 335px;
        }
        #flotPie1  {
            height: 150px;
        }
        #flotPie1 td {
            padding:3px;
        }
        #flotPie1 table {
            top: 20px!important;
            right: -10px!important;
        }
        .chart-container {
            display: table;
            min-width: 270px ;
            text-align: left;
            padding-top: 10px;
            padding-bottom: 10px;
        }
        #flotLine5  {
             height: 105px;
        }

        #flotBarChart {
            height: 150px;
        }
        #cellPaiChart{
            height: 160px;
        }

    </style>
</head>

<body>
    <!-- Left Panel -->
    <aside id="left-panel" class="left-panel">
        <nav class="navbar navbar-expand-sm navbar-default">
            <div id="main-menu" class="main-menu collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active">
                        <a href="index_Insumos.aspx"><i class="menu-icon fa fa-laptop"></i>Tablero </a>
                    </li>
                    <li class="menu-title">Insumos</li><!-- /.menu-title -->
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon fa fa-cogs"></i>Solicitudes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod1 = 1 And Vg_Fac1 < 3 Then %>
                            <li><i class="fa fa-id-card-o"></i><asp:HyperLink ID="HyperLink1" NavigateUrl ="AppI_SolicitudxNew.aspx" runat="server">Nueva</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod2 = 2 And Vg_Fac2 < 3 Then %>
                            <li><i class="ti-zoom-in"></i><asp:HyperLink ID="HyperLink2" NavigateUrl ="AppI_SolicitudXValidar.aspx" runat="server">Por Validar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod3 = 3 And Vg_Fac3 < 3 Then %>
                            <li><i class="ti-pencil-alt"></i><asp:HyperLink ID="HyperLink3" NavigateUrl ="AppI_SolicitudXAprobar.aspx" runat="server">Por Aprobar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod4 = 4 And Vg_Fac4 < 3 Then %>
                            <li><i class="ti-check"></i><asp:HyperLink ID="HyperLink4" NavigateUrl ="AppI_SolicitudxAprobarRM.aspx" runat="server">Por Aprobar RM</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod5 = 5 And Vg_Fac5 < 3 Then %>
                            <li><i class="pe-7s-cart"></i><asp:HyperLink ID="HyperLink5" NavigateUrl ="AppI_SolicitudxSurtir.aspx" runat="server">Por Surtir</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod6 = 6 And Vg_Fac6 < 3 Then %>
                            <li><i class="ti-thumb-up"></i><asp:HyperLink ID="HyperLink6" NavigateUrl ="AppI_SolicitudxVoBo.aspx" runat="server">VoBo</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod9 = 9 And Vg_Fac9 < 3 Then %>
                            <li><i class="ti-thumb-down"></i><asp:HyperLink ID="HyperLink13" NavigateUrl ="AppI_SolicitudxRechazar.aspx" runat="server">Rechazadas</asp:HyperLink></li>
                            <% End If %>
                        </ul>
                    </li>

                    <li class="menu-title">Estadisticas</li><!-- /.menu-title -->

                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon ti-files"></i>Reportes Solicitudes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            
                            <% If Vg_mod7 = 7 And Vg_Fac7 < 3 Then %>
                            <li><i class="ti-bookmark-alt"></i><asp:HyperLink ID="HyperLink12" NavigateUrl ="AppI_PorEstatus.aspx" runat="server">Por Estatus</asp:HyperLink></li>
                            <% End If %>
                        </ul>
                    </li>

                </ul>
            </div><!-- /.navbar-collapse -->
        </nav>
    </aside>
    <!-- /#left-panel -->
    <!-- Right Panel -->
    <div id="right-panel" class="right-panel">
        <!-- Header-->
        <header id="header" class="header">
            <div class="top-left">
                <div class="navbar-header">
                    <a class="navbar-brand" href="portal.aspx"><img src="images/logo3.png" alt="Logo"></a>
                    <a class="navbar-brand hidden" href="./"><img src="images/logo2.png" alt="Logo"></a>
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
                            <a class="nav-link" href="./MiPerfil.aspx"><i class="fa fa- user"></i>Mi Perfil</a>
                            <a class="nav-link" href="./" onclick="<script> self.close(); </script>"><i class="fa fa-power -off"></i>Logout</a>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!-- /#header -->
        <!-- Content -->
        <div class="content">


            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <strong class="card-title">Solicitudes de Insumos</strong>
                    </div>
                    <div class="card-body">

                        <!-- Animated -->
                        <div class="animated fadeIn">
                            <!-- Widgets  -->
                            <div class="row">
                                <% If Vg_mod2 = 2 And Vg_Fac2 < 3 Then %>
                                <div class="col-lg-4 col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="stat-widget-five ">
                                                <div class="stat-icon dib flat-color-2">
                                                    <i class="ti-zoom-in"></i>
                                                </div>
                                                <div class="stat-content">
                                                    <div class="text-left dib">
                                                        <div class="stat-text"><span class="count"><%=vg_xValidar %></span></div>
                                                         <div class="stat-heading"><asp:HyperLink ID="HyperLink15" NavigateUrl ="AppI_SolicitudXValidar.aspx" runat="server">Por Validar</asp:HyperLink></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% End If %>
                                <% If Vg_mod3 = 3 And Vg_Fac3 < 3 Then %>
                                <div class="col-lg-4 col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="stat-widget-five">
                                                <div class="stat-icon dib flat-color-3">
                                                    <i class="ti-pencil-alt"></i>
                                                </div>
                                                <div class="stat-content">
                                                    <div class="text-left dib">
                                                        <div class="stat-text"><span class="count"><%=vg_xAprobar %></span></div>
                                                         <div class="stat-heading"><asp:HyperLink ID="HyperLink7" NavigateUrl ="AppI_SolicitudXAprobar.aspx" runat="server">Por Aprobar</asp:HyperLink></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% End If %>
                                <% If Vg_mod4 = 4 And Vg_Fac4 < 3 Then %>
                                <div class="col-lg-4 col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="stat-widget-five">
                                                <div class="stat-icon dib flat-color-7">
                                                    <i class="ti-check"></i>
                                                </div>
                                                <div class="stat-content">
                                                    <div class="text-left dib">
                                                        <div class="stat-text"><span class="count"><%=vg_xAprobarRM %></span></div>
                                                         <div class="stat-heading"><asp:HyperLink ID="HyperLink8" NavigateUrl ="AppI_SolicitudxAprobarRM.aspx" runat="server">Por Aprobar RM</asp:HyperLink></div>
                                                    
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% End If %>
                            </div>
                            <div class="row">
                                <% If Vg_mod5 = 5 And Vg_Fac5 < 3 Then %>
                                <div class="col-lg-4 col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="stat-widget-five">
                                                <div class="stat-icon dib flat-color-6">
                                                    <i class="pe-7s-cart"></i>
                                                </div>
                                                <div class="stat-content">
                                                    <div class="text-left dib">
                                                        <div class="stat-text"><span class="count"><%=vg_xSurtir %></span></div>
                                                         <div class="stat-heading"><asp:HyperLink ID="HyperLink9" NavigateUrl ="AppI_SolicitudxSurtir.aspx" runat="server">Por Surtir</asp:HyperLink></div>
                                                    
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% End If %>
                                <% If Vg_mod6 = 6 And Vg_Fac6 < 3 Then %>
                                <div class="col-lg-4 col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="stat-widget-five">
                                                <div class="stat-icon dib flat-color-1">
                                                    <i class="ti-thumb-up"></i>
                                                </div>
                                                <div class="stat-content">
                                                    <div class="text-left dib">
                                                        <div class="stat-text"><span class="count"><%=vg_xVoBo %></span></div>
                                                         <div class="stat-heading"><asp:HyperLink ID="HyperLink10" NavigateUrl ="AppI_SolicitudxVoBo.aspx" runat="server">VoBo</asp:HyperLink></div>
                                                    
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% End If %>
                                <% If Vg_mod9 = 9 And Vg_Fac9 < 3 Then %>
                                <div class="col-lg-4 col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="stat-widget-five">
                                                <div class="stat-icon dib flat-color-4">
                                                    <i class="ti-thumb-down"></i>
                                                </div>
                                                <div class="stat-content">
                                                    <div class="text-left dib">
                                                        <div class="stat-text"><span class="count"><%=vg_xRechazar %></span></div>
                                                         <div class="stat-heading"><asp:HyperLink ID="HyperLink14" NavigateUrl ="AppI_SolicitudxRechazar.aspx" runat="server">Rechazadas</asp:HyperLink></div>
                                                    
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% End If %>
                            </div>
                            <!-- /Widgets -->
                            <!--  Traffic  -->
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="card">
                                        <div class="row">
                                            <div class="col-lg-8">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <h4 class="mb-3">Solicitud Por Estatus </h4>
                                                        <canvas id="singelBarChart"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-4">
                                                <div class="card-body">
                                                    <div class="progress-box progress-1">
                                                        <h4 class="por-title">Por Validar</h4>
                                                        <div class="por-txt">(<%=FormatNumber(vg_TotxValidar, 2) %>%)</div>
                                                        <div class="progress mb-2" style="height: 5px;">
                                                            <div class="progress-bar bg-flat-color-1" role="progressbar" style=" <%= "width:" & CStr(vg_TotxValidar) & "%;" %>"  aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                    <div class="progress-box progress-2">
                                                        <h4 class="por-title">Por Aprobar</h4>
                                                        <div class="por-txt">(<%=FormatNumber(vg_TotxAprobar, 2)  %>%)</div>
                                                        <div class="progress mb-2" style="height: 5px;">
                                                            <div class="progress-bar bg-flat-color-2" role="progressbar" style=" <%= "width:" & CStr(vg_TotxAprobar) & "%;" %>" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                    <div class="progress-box progress-2">
                                                        <h4 class="por-title">Por Aprobar RM</h4>
                                                        <div class="por-txt">(<%=FormatNumber(vg_TotxAprobarRM, 2) %>%)</div>
                                                        <div class="progress mb-2" style="height: 5px;">
                                                            <div class="progress-bar bg-flat-color-3" role="progressbar" style=" <%= "width:" & CStr(vg_TotxAprobarRM) & "%;" %>" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                    <div class="progress-box progress-2">
                                                        <h4 class="por-title">Por Surtir</h4>
                                                        <div class="por-txt">(<%=FormatNumber(vg_TotxSurtir, 2) %>%)</div>
                                                        <div class="progress mb-2" style="height: 5px;">
                                                            <div class="progress-bar bg-flat-color-4" role="progressbar" style=" <%= "width:" & CStr(vg_TotxSurtir) & "%;" %>" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>

                                                    <div class="progress-box progress-2">
                                                        <h4 class="por-title">VoBo</h4>
                                                        <div class="por-txt">(<%=FormatNumber(vg_TotVoBo, 2) %>%)</div>
                                                        <div class="progress mb-2" style="height: 5px;">
                                                            <div class="progress-bar bg-flat-color-5" role="progressbar" style=" <%= "width:" & CStr(vg_TotVoBo) & "%;" %>" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>

                                                    <div class="progress-box progress-2">
                                                        <h4 class="por-title">Rechazadas</h4>
                                                        <div class="por-txt">(<%=FormatNumber(vg_TotRechazadas, 2) %>%)</div>
                                                        <div class="progress mb-2" style="height: 5px;">
                                                            <div class="progress-bar bg-flat-color-5" role="progressbar" style=" <%= "width:" & CStr(vg_TotRechazadas) & "%;" %>" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>

                                                </div> <!-- /.card-body -->
                                            </div>
                                        </div> <!-- /.row -->
                                        <div class="card-body"></div>
                                    </div>
                                </div><!-- /# column -->
                            </div>
                            <!--  /Traffic -->
                            <div class="clearfix"></div>

                        </div>
                        <!-- .animated -->

                    </div>
                    <!-- .col-md-12 -->
                </div>
                <!-- .card -->
            </div>
            <!-- .card-body -->

        </div>
       <!-- /.content -->
                    <div class="clearfix"></div>
                    <!-- Footer -->
                    <footer class="site-footer">
                        <div class="footer-inner bg-white">
                            <div class="row">
                                <div class="col-sm-6">
                                    <!--Copyright &copy; 2018 Empresa-->
                                </div>
                                <div class="col-sm-4 text-center">
                                    <i class="fa fa-envelope"></i>
                                    <asp:HyperLink ID="HyperLink16" NavigateUrl ="https://discord.gg/tdeNj3Bneh" runat="server">Contactanos</asp:HyperLink>
                                </div>
                                <div class="col-sm-6 text-right">
                                    <!--Designed by <a href="https://colorlib.com">Empresa</a>-->
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

                <!--Local Stuff-->
                <script>
                    jQuery(document).ready(function ($) {
                        "use strict";
                        // single bar chart
                        var ctx = document.getElementById("singelBarChart");
                        ctx.height = 250;
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: ["Validar", "Aprobar", "AprobarRM", "Surtir", "VoBo", "Rechazadas"],
                                datasets: [
                                    {
                                        label: "Total",
                                        data: [<%=(vg_TotxValidar)%>, <%=CInt(vg_TotxAprobar)%>, <%=CInt(vg_TotxAprobarRM)%>, <%=CInt(vg_TotxSurtir)%>, <%=vg_TotVoBo%>, <%=vg_TotRechazadas%>],
                                        borderColor: "rgba(0, 194, 146, 0.9)",
                                        borderWidth: "0",
                                        backgroundColor: "rgba(0, 194, 146, 0.5)"
                                    }
                                ]
                            },
                            options: {
                                scales: {
                                    yAxes: [{
                                        ticks: {
                                            beginAtZero: true
                                        }
                                    }]
                                }
                            }
                        });

                    });
                </script>
</body>
</html>
