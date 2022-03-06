<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data.SqlClient" %>

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

    Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
	    If Not Session("UsuAppV") <> "" Then
            Response.Write("<script>window.open('errorSesion.aspx',target='_self');<" & "/" & "script>")
        End If
		SP_GetPermiso()
        'Dim dsColumnas As New DataSet
        If Not Page.IsPostBack() Then
            'Obtienes Secretarias
            SP_GetSecretarias()
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
        coDetalle.CommandText = "AppV_SPGetPermiso"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        'Parámetros si hubieran
        Dim miParam As New SqlParameter("@vp_UsuUsuario", SqlDbType.Char)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        coDetalle.Parameters("@vp_UsuUsuario").Value = Session("UsuAppV")

        Dim miParam1 As New SqlParameter("@vp_PerClave", SqlDbType.Char)
        miParam1.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam1)
        coDetalle.Parameters("@vp_PerClave").Value = CInt(Session("UsuPer"))

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        While registro.Read

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

    Sub SP_GetSecretarias()
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppV_SPGetSecretarias"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        'Parámetros si hubieran
        'Dim miParam As New SqlParameter("@Usu_Clave", SqlDbType.VarChar)
        'miParam.Direction = ParameterDirection.Input
        'coDetalle.Parameters.Add(miParam)
        'coDetalle.Parameters("@Usu_Clave").Value = vl_cveusu

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        DDL_Secretarias.DataTextField = "Sec_Descripcion"
        DDL_Secretarias.DataValueField = "Sec_Clave"
        DDL_Secretarias.DataSource = registro
        DDL_Secretarias.DataBind()
        DDL_Secretarias.Items.Insert(0, "Selecciona una Secretaria")
        DDL_Secretarias.SelectedIndex = 0


        registro.Close()
        myConnection.Close()
    End Sub

    Sub Calendar1_SelectionChanged(sender As Object, e As EventArgs)

        Txt_DateSol.Text = Calendar1.SelectedDate.ToShortDateString()

    End Sub

    Sub Calendar2_SelectionChanged(sender As Object, e As EventArgs)

        Txt_DateFly.Text = Calendar2.SelectedDate.ToShortDateString()

    End Sub

    Sub SP_GetSolicitudxRepResumen()
        Dim myConnection As SqlConnection

        CleanCampos()

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppV_SPGetSolicitudxRepResumen"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        Dim dtTable As New DataTable

        'Parámetros si hubieran
        Dim miParam As New SqlParameter("@vp_Mov_Fecha", SqlDbType.VarChar)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        coDetalle.Parameters("@vp_Mov_Fecha").Value = Txt_DateSol.Text.Trim

        Dim miParam1 As New SqlParameter("@Sol_FechaVueloSalida", SqlDbType.VarChar)
        miParam1.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam1)
        coDetalle.Parameters("@Sol_FechaVueloSalida").Value = Txt_DateFly.Text.Trim

        'Dim miParam2 As New SqlParameter("@vp_Pas_ApMaterno", SqlDbType.VarChar)
        'miParam2.Direction = ParameterDirection.Input
        'coDetalle.Parameters.Add(miParam2)
        'coDetalle.Parameters("@vp_Pas_ApMaterno").Value = Txt_ApMaterno.Text.Trim

        'Dim miParam3 As New SqlParameter("@Sol_Clave", SqlDbType.VarChar)
        'miParam3.Direction = ParameterDirection.Input
        'coDetalle.Parameters.Add(miParam3)
        'coDetalle.Parameters("@Sol_Clave").Value = Txt_ApMaterno.Text.Trim

        'Dim miParam5 As New SqlParameter("@Sot_Clave", SqlDbType.Int)
        'miParam5.Direction = ParameterDirection.Input
        'coDetalle.Parameters.Add(miParam5)
        'coDetalle.Parameters("@Sot_Clave").Value = 5 ' Boleto Asignado

        If DDL_Secretarias.SelectedIndex > 0 Then
            Dim miParam4 As New SqlParameter("@vp_Sec_Clave", SqlDbType.Int)
            miParam4.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam4)
            coDetalle.Parameters("@vp_Sec_Clave").Value = CInt(DDL_Secretarias.Items(DDL_Secretarias.SelectedIndex).Value)
        End If

        'ImageButton1.Enabled = True
        'MsgBox(DDL_Secretarias.Items(DDL_Secretarias.SelectedIndex).Value)

        daDetalle.Fill(dtTable)
        GV_Pasajero.DataSource = dtTable
        GV_Pasajero.DataBind()

        myConnection.Close()

        'Response.Write("<script>javascript: document.getElementById('scrollmodal').style.display = 'block';<" & "/" & "script>")
    End Sub

    Protected Sub GV_Pasajero_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If (e.Row.RowType = DataControlRowType.Header) Then
            e.Row.Cells(7).Visible = False
            e.Row.Cells(8).Visible = False
            e.Row.Cells(9).Visible = False
            e.Row.Cells(10).Visible = False
            e.Row.Cells(11).Visible = False
            e.Row.Cells(12).Visible = False
            e.Row.Cells(13).Visible = False
            e.Row.Cells(14).Visible = False
            e.Row.Cells(15).Visible = False
            e.Row.Cells(16).Visible = False
            e.Row.Cells(17).Visible = False
            e.Row.Cells(0).Font.Size = 7
            e.Row.Cells(1).Font.Size = 7
            e.Row.Cells(2).Font.Size = 7
            e.Row.Cells(3).Font.Size = 7
            e.Row.Cells(4).Font.Size = 7
            e.Row.Cells(5).Font.Size = 7
            e.Row.Cells(6).Font.Size = 7
            e.Row.Cells(0).Text = "Sel"
            e.Row.Cells(1).Text = "No"
            e.Row.Cells(2).Text = "FECHA SOL"
            e.Row.Cells(3).Text = "NOMBRE"
            e.Row.Cells(4).Text = "PATERNO"
            e.Row.Cells(5).Text = "MATERNO"
            e.Row.Cells(6).Text = "VUELO"

        End If
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            e.Row.Cells(7).Visible = False
            e.Row.Cells(8).Visible = False
            e.Row.Cells(9).Visible = False
            e.Row.Cells(10).Visible = False
            e.Row.Cells(11).Visible = False
            e.Row.Cells(12).Visible = False
            e.Row.Cells(13).Visible = False
            e.Row.Cells(14).Visible = False
            e.Row.Cells(15).Visible = False
            e.Row.Cells(16).Visible = False
            e.Row.Cells(17).Visible = False
            e.Row.Cells(0).Font.Size = 7
            e.Row.Cells(1).Font.Size = 7
            e.Row.Cells(2).Font.Size = 7
            e.Row.Cells(3).Font.Size = 7
            e.Row.Cells(4).Font.Size = 7
            e.Row.Cells(5).Font.Size = 7
            e.Row.Cells(6).Font.Size = 7
        End If
    End Sub

    Protected Sub GV_Pasajero_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim row As GridViewRow = GV_Pasajero.SelectedRow

        Lbl_Datos.Text = "No:" & Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("No")) & " -- Fecha:" & Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("FechaSol")) &
            " -- Vuelo: " & Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("VuT_Descripcion"))
        Txt_Nombre.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Pas_Nombre"))
        Txt_ApPaterno.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Pas_ApPaterno"))
        Txt_ApMaterno.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Pas_ApMaterno"))
        Txt_FechaVueloSal.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_FechaVueloSalida"))
        TxtFechaVueloReg.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_FechaVueloRegreso"))
        Txt_HourFlyExit.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_HoraVueloSalida"))
        Txt_HourFlyRet.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_HoraVueloRegreso"))
        Txt_Origen.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_Origen"))
        Txt_Destino.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_Destino"))
        Txt_Aerolinea.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Aer_Descripcion"))
        Txt_Reservacion.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_Reservacion"))
        Txt_Costo.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_Costo"))
        Txt_Secretaria.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sec_Descripcion"))
        Txt_Agencia.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Age_Descripcion"))

    End Sub

    Sub CleanCampos()
        Lbl_Datos.Text = ""
        Txt_Nombre.Text = ""
        Txt_ApPaterno.Text = ""
        Txt_ApMaterno.Text = ""
        Txt_FechaVueloSal.Text = ""
        TxtFechaVueloReg.Text = ""
        Txt_HourFlyExit.Text = ""
        Txt_HourFlyRet.Text = ""
        Txt_Origen.Text = ""
        Txt_Destino.Text = ""
        Txt_Aerolinea.Text = ""
        Txt_Reservacion.Text = ""
        Txt_Costo.Text = ""
        Txt_Secretaria.Text = ""
        Txt_Agencia.Text = ""
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

<body oncontextmenu="return false">
    <!-- Left Panel -->
    <aside id="left-panel" class="left-panel">
        <nav class="navbar navbar-expand-sm navbar-default">
            <div id="main-menu" class="main-menu collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active">
                        <a href="index.aspx"><i class="menu-icon fa fa-laptop"></i>Tablero </a>
                    </li>
                    <li class="menu-title">Vuelos</li><!-- /.menu-title -->
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon fa fa-cogs"></i>Solicitudes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod1 = 1 And Vg_Fac1 < 3 Then %>
                            <li><i class="fa fa-id-card-o"></i><asp:HyperLink ID="HyperLink1" NavigateUrl ="AppV_SolicitudNew.aspx" runat="server">Nueva</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod2 = 2 And Vg_Fac2 < 3 Then %>
                            <li><i class="pe-7s-cash"></i><asp:HyperLink ID="HyperLink2" NavigateUrl ="AppV_SolicitudxCotizar.aspx" runat="server">Por Cotizar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod3 = 3 And Vg_Fac3 < 3 Then %>
                            <li><i class="ti-pencil-alt"></i><asp:HyperLink ID="HyperLink3" NavigateUrl ="AppV_SolicitudxValidar.aspx" runat="server">Por Validar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod4 = 4 And Vg_Fac4 < 3 Then %>
                            <li><i class="ti-check"></i><asp:HyperLink ID="HyperLink4" NavigateUrl ="AppV_SolicitudxAprobar.aspx" runat="server">Por Aprobar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod5 = 5 And Vg_Fac5 < 3 Then %>
                            <li><i class="pe-7s-cart"></i><asp:HyperLink ID="HyperLink5" NavigateUrl ="AppV_SolicitudxComprar.aspx" runat="server">Por Comprar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod6 = 6 And Vg_Fac6 < 3 Then %>
                            <li><i class="ti-thumb-up"></i><asp:HyperLink ID="HyperLink6" NavigateUrl ="AppV_SolicitudxBoletoAsig.aspx" runat="server">Boleto Asignado</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod7 = 7 And Vg_Fac7 < 3 Then %>
                            <li><i class="ti-thumb-down"></i><asp:HyperLink ID="HyperLink7" NavigateUrl ="AppV_SolicitudxRechazar.aspx" runat="server">Rechazadas</asp:HyperLink></li>
                            <% End If %>
                        </ul>
                    </li>

                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon ti-id-badge"></i>Pasajeros
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <li><i class="ti-arrow-up"></i><a href="AppV_PasajeroNew.aspx">Alta</a></li>
                            <li><i class="ti-search"></i><a href="AppV_PasajeroSearch.aspx">Consulta</a></li>
                            <li><i class="ti-arrows-horizontal"></i><a href="AppV_PasajeroChange.aspx">Cambio</a></li>
                        </ul>
                    </li>

                    <li class="menu-title">Estadisticas</li><!-- /.menu-title -->

                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon ti-files"></i>Reportes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod8 = 8 And Vg_Fac8 < 3 Then %>
                            <li><i class="ti-agenda"></i><asp:HyperLink ID="HyperLink11" NavigateUrl ="AppV_SolicitudxRechazar.aspx" runat="server">Mensual por Proveedor</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod9 = 9 And Vg_Fac9 < 3 Then %>
                            <li><i class="ti-bookmark-alt"></i><asp:HyperLink ID="HyperLink12" NavigateUrl ="AppV_ReportResumen.aspx" runat="server">Autorizados por Agencia</asp:HyperLink></li>
                            <% End If %>
                        </ul>
                    </li>

                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </nav>
    </aside>
    <!-- /#left-panel -->
    <!-- Right Panel -->
    <div id="right-panel" class="right-panel">
        <!-- Header-->
        <header id="header" class="header">
            <div class="top-left">
                <div class="navbar-header">
                    <a class="navbar-brand" href="./">
                        <img src="images/logo.png" alt="Logo"></a>
                    <a class="navbar-brand hidden" href="./">
                        <img src="images/logo2.png" alt="Logo"></a>
                    <a id="menuToggle" class="menutoggle"><i class="fa fa-bars"></i></a>

                </div>
            </div>

            <div class="top-right">

                <div class="header-menu">
                    <div class="header-left">

                        <div class="dropdown for-notification">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="notification" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-bell"></i>
                                <span class="count bg-danger">3</span>
                            </button>
                            <div class="dropdown-menu" aria-labelledby="notification">
                                <p class="red">You have 3 Notification</p>
                                <a class="dropdown-item media" href="#">
                                    <i class="fa fa-check"></i>
                                    <p>Server #1 overloaded.</p>
                                </a>
                                <a class="dropdown-item media" href="#">
                                    <i class="fa fa-info"></i>
                                    <p>Server #2 overloaded.</p>
                                </a>
                                <a class="dropdown-item media" href="#">
                                    <i class="fa fa-warning"></i>
                                    <p>Server #3 overloaded.</p>
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="user-area dropdown float-right">
                        <a href="#" class="dropdown-toggle active" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img class="user-avatar rounded-circle" src="images/admin.jpg" alt="User Avatar">
                        </a>

                        <div class="user-menu dropdown-menu">
                            <a class="nav-link" href="#"><i class="fa fa- user"></i>Mi Perfil</a>

                            <a class="nav-link" href="#"><i class="fa fa- user"></i>Notificaciones <span class="count">13</span></a>

                            <a class="nav-link" href="#"><i class="fa fa -cog"></i>Configuracion</a>

                            <a class="nav-link" href="#"><i class="fa fa-power -off"></i>Logout</a>
                        </div>
                    </div>

                </div>
            </div>
        </header>
        <!-- /#header -->
        <!-- Content -->
        <div class="content">

            <form id="form1" method="post" runat="server" target="_self">

                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <strong class="card-title">Reportes / Autorizados por Agencia</strong>
                        </div>
                        <div class="card-body">

                            <div class="col-lg-12 col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <strong>Boleto Asignado</strong>
                                    </div>
                                    <div class="card-body card-block" >
                                        <!-- .table-stats -->
                                        <table class="table " style="overflow-x: scroll;">
                                            <tbody>
                                                <tr>
                                                    <td width="33%">
                                                        <div class="form-group">
                                                            <label class=" form-control-label">Fecha de Solicitud</label>
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <asp:TextBox ID="Txt_DateSol" class="form-control" runat="server" MaxLength="10" data-toggle="modal" data-target="#FechaModal"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td width="33%">
                                                        <div class="form-group">
                                                            <label class=" form-control-label">Fecha Vuelo </label>
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <asp:TextBox ID="Txt_DateFly" class="form-control" MaxLength="10" runat="server" data-toggle="modal" data-target="#FechaModalRet"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td width="33%">

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" width="66%">
                                                        <div class="form-group">
                                                            <div class="input-group">
                                                                <label class=" form-control-label">Secretaria</label>
                                                                <div class="input-group">
                                                                    <asp:DropDownList ID="DDL_Secretarias" class="form-control" runat="server"></asp:DropDownList>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td width="33%" style="align-items: center">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="33%"></td>
                                                    <td width="33%">
                                                        <div class="form-group">
                                                            <div class="input-group">
                                                                <div class="input-group">
                                                                    <!-- <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#scrollmodal"><i class="fa fa-search"></i>&nbsp; Buscar</button> -->
                                                                    <asp:Button ID="Btn_Buscar" runat="server" Text="Buscar" class="btn btn-success btn-sm" OnClick="SP_GetSolicitudxRepResumen" />
                                                                    <asp:TextBox ID="Txt_SolClaveCon" runat="server" Visible="False"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td width="33%"></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" width="99%">
                                                        <asp:Panel ID="Panel1" runat="server" ScrollBars="Vertical" Height="100px">
                                                        <div class="form-group">
                                                            <asp:GridView ID="GV_Pasajero" runat="server" Width="100%" OnRowDataBound="GV_Pasajero_RowDataBound"
                                                                CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GV_Pasajero_SelectedIndexChanged"
                                                                DataKeyNames="No,FechaSol,Pas_Nombre,Pas_ApPaterno,Pas_ApMaterno,
                                                                            VuT_Descripcion,Sol_FechaVueloSalida, Sol_FechaVueloRegreso,
                                                                            Sol_HoraVueloSalida, Sol_HoraVueloRegreso, Sol_Origen, Sol_Destino,
                                                                            Aer_Descripcion, Sol_Reservacion, Sol_Costo,
                                                                            Sec_Descripcion, Age_Descripcion">

                                                                <Columns>
                                                                    <asp:CommandField ShowSelectButton="True" SelectText="Ok" ButtonType="Image" SelectImageUrl="~/images/Edit.jpg"></asp:CommandField>

                                                                </Columns>

                                                                <AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>

                                                                <EditRowStyle BackColor="#999999"></EditRowStyle>

                                                                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></FooterStyle>

                                                                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"></HeaderStyle>

                                                                <PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White"></PagerStyle>

                                                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333"></RowStyle>

                                                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333"></SelectedRowStyle>

                                                                <SortedAscendingCellStyle BackColor="#E9E7E2"></SortedAscendingCellStyle>

                                                                <SortedAscendingHeaderStyle BackColor="#506C8C"></SortedAscendingHeaderStyle>

                                                                <SortedDescendingCellStyle BackColor="#FFFDF8"></SortedDescendingCellStyle>

                                                                <SortedDescendingHeaderStyle BackColor="#6F8DAE"></SortedDescendingHeaderStyle>
                                                            </asp:GridView>
                                                        </div>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <!-- /.table-stats -->
                                    </div>
                                </div>
                            </div>

                        <!-- Solicitud -->
                        <div class="col-lg-12 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong>Solicitud: </strong> <asp:Label ID="Lbl_Datos" runat="server" Text="Label"></asp:Label>
                                </div>
                                <div class="card-body card-block">
                                    <!-- .table-stats -->
                                    <table class="table ">
                                        <tbody>
                                            <tr>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Nombre</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                                                    <asp:TextBox ID="Txt_Nombre" class="form-control" runat="server" MaxLength="50" disabled=""></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Apellido Paterno</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                                                    <asp:TextBox ID="Txt_ApPaterno" class="form-control" runat="server" MaxLength="50" disabled=""></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Apellido Materno</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                                                    <asp:TextBox ID="Txt_ApMaterno" class="form-control" runat="server" MaxLength="50" disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Fecha Vuelo</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <asp:TextBox ID="Txt_FechaVueloSal" class="form-control" runat="server" disabled=""></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Fecha Vuelo</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <asp:TextBox ID="TxtFechaVueloReg" class="form-control" runat="server" disabled=""></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Horario Vuelo Salida</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            <asp:TextBox ID="Txt_HourFlyExit" runat="server" class="form-control"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Horario Vuelo Regreso</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            <asp:TextBox ID="Txt_HourFlyRet" runat="server"  class="form-control"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Origen</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <asp:TextBox ID="Txt_Origen" class="form-control" runat="server"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Destino</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <asp:TextBox ID="Txt_Destino" class="form-control" runat="server"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Aerolinea</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            <asp:TextBox ID="Txt_Aerolinea" runat="server" class="form-control"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Reservacion</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <asp:TextBox ID="Txt_Reservacion" class="form-control" runat="server"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Costo</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <asp:TextBox ID="Txt_Costo" class="form-control" runat="server"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan ="2" width="66%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Secretaria</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                            <asp:TextBox ID="Txt_Secretaria" runat="server" class="form-control"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Agencia</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <asp:TextBox ID="Txt_Agencia" class="form-control" runat="server"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <!-- /.table-stats -->
                                </div>
                            </div>
                        <!-- /Solicitud -->
                        </div>

                        </div>
                        <!-- .card-body -->
                    </div>
                    <!-- .card -->
                </div>
                <!-- .col-md-12 -->

                <div class="modal fade" id="FechaModal" tabindex="-1" role="dialog" aria-labelledby="FechaModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="FechaModalLabel">Selecciona la Fecha</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <asp:Calendar ID="Calendar1" runat="server"
                                                OnSelectionChanged="Calendar1_SelectionChanged" Visible="True" Width="30px" Height="40px"
                                                Font-Size="Smaller" DayHeaderStyle-Font-Size="Smaller"></asp:Calendar>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="FechaModalRet" tabindex="-1" role="dialog" aria-labelledby="FechaModalRetLabel" aria-hidden="true">
                    <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="FechaModalRetLabel">Selecciona la Fecha</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <asp:Calendar ID="Calendar2" runat="server"
                                                OnSelectionChanged="Calendar2_SelectionChanged" Visible="True" Width="30px" Height="40px"
                                                Font-Size="Smaller" DayHeaderStyle-Font-Size="Smaller"></asp:Calendar>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </form>

        </div>
        <!-- /.content -->
        <div class="clearfix"></div>
        <!-- Footer -->
        <footer class="site-footer">
            <div class="footer-inner bg-white">
                <div class="row">
                    <div class="col-sm-6">
                        Copyright &copy; 2018 Empresa
                    </div>
                    <div class="col-sm-6 text-right">
                        Designed by <a href="https://colorlib.com">Empresa</a>
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

    <script type="text/javascript">
        $(document).ready(function () {
            $('#bootstrap-data-table-export').DataTable();
        });
    </script>
</body>
</html>
