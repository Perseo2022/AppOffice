<%@Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@Import Namespace = "System" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace = "System.Data" %>
<%@Import Namespace = "System.Data.OleDb" %>
<%@Import Namespace = "System.Data.SqlClient" %>

<script runat="server">
    Dim vg_Name As String = ""
    Dim vg_LastName As String = ""
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
        'If Not Session("UsuAppV") <> "" Then
        '    Server.Transfer("portal.aspx")
        'End If
        'Dim dsColumnas As New DataSet
        SP_GetPermiso()
        If Not Page.IsPostBack() Then

            'Obtiene Tipo de Requerimiento
            'SP_GetReq()
            'Obtiene Tipo de Vuelo
            'SP_GetTipoVuelo()
            'Obtienes Secretarias
            SP_GetSecretarias()
            ISP_GetInsumosTipo()
            ISP_GetEnlaces()
            CSP_GetUniPptal()
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

    Sub CSP_GetUniPptal()
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppC_SPGetUniPptal"
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

        DDL_UniPptal.DataTextField = "CUptal_Descripcion"
        'iDDL_UniPptal.DataTextField = "CUptal_Clave"
        DDL_UniPptal.DataValueField = "CUptal_Clave"
        DDL_UniPptal.DataSource = registro
        DDL_UniPptal.DataBind()
        DDL_UniPptal.Items.Insert(0, "Selecciona una Unidad")

        registro.Close()
        myConnection.Close()
    End Sub

    Sub ISP_GetInsumosTipo()
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppI_SPGetInsumosTipo"
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

        DDL_TipoSol.DataTextField = "InT_Descripcion"
        DDL_TipoSol.DataValueField = "InT_Clave"
        DDL_TipoSol.DataSource = registro
        DDL_TipoSol.DataBind()
        DDL_TipoSol.Items.Insert(0, "Selecciona un Tipo")

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
        coDetalle.CommandText = "AppV_SPGetSecretariaByUser"
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

        DDL_Secretarias.DataTextField = "Sec_Descripcion"
        DDL_Secretarias.DataValueField = "Sec_Clave"
        DDL_Secretarias.DataSource = registro
        DDL_Secretarias.DataBind()
        DDL_Secretarias.Items.Insert(0, "Selecciona una Secretaria")
        DDL_Secretarias.SelectedIndex = 0


        registro.Close()
        myConnection.Close()
    End Sub

    Sub ISP_GetEnlaces()
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppI_SPGetEnlaces"
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

        DDL_Enlaces.DataTextField = "IEn_Descripcion"
        DDL_Enlaces.DataValueField = "IEn_Clave"
        DDL_Enlaces.DataSource = registro
        DDL_Enlaces.DataBind()
        DDL_Enlaces.Items.Insert(0, "Selecciona un Enlace")
        DDL_Enlaces.SelectedIndex = 0


        registro.Close()
        myConnection.Close()
    End Sub

    Sub CSP_SetSolicitudNew()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppC_SPSetSolicitudNew"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        Dim dtTable As New DataTable

        'Parámetros si hubieran
        If DDL_Secretarias.SelectedIndex > 0 Then
            Dim miParam As New SqlParameter("@Sec_Clave", SqlDbType.Int)
            miParam.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam)
            coDetalle.Parameters("@Sec_Clave").Value = CInt(DDL_Secretarias.Items(DDL_Secretarias.SelectedIndex).Value)
        End If

        If DDL_TipoSol.SelectedIndex > 0 Then
            Dim miParam1 As New SqlParameter("@InT_Clave", SqlDbType.Int)
            miParam1.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam1)
            coDetalle.Parameters("@InT_Clave").Value = CInt(DDL_TipoSol.Items(DDL_TipoSol.SelectedIndex).Value)
        End If

        If DDL_UniPptal.SelectedIndex > 0 Then
            Dim miParam2 As New SqlParameter("@CUptal_Clave", SqlDbType.Char)
            miParam2.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam2)
            coDetalle.Parameters("@CUptal_Clave").Value = CInt(DDL_UniPptal.Items(DDL_UniPptal.SelectedIndex).Value)
        End If

        If DDL_Enlaces.SelectedIndex > 0 Then
            Dim miParam3 As New SqlParameter("@IEn_Clave", SqlDbType.Char)
            miParam3.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam3)
            coDetalle.Parameters("@IEn_Clave").Value = CInt(DDL_Enlaces.Items(DDL_Enlaces.SelectedIndex).Value)
        End If

        Dim miParam4 As New SqlParameter("@CSol_ObjPart", SqlDbType.Char)
        miParam4.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam4)
        coDetalle.Parameters("@CSol_ObjPart").Value = Txt_ObPartido.Text.Trim

        Dim miParam5 As New SqlParameter("@CSol_UbiEdificio", SqlDbType.Char)
        miParam5.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam5)
        coDetalle.Parameters("@CSol_UbiEdificio").Value = Txt_Edificio.Text.Trim

        Dim miParam6 As New SqlParameter("@CSol_UbiPiso", SqlDbType.Char)
        miParam6.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam6)
        coDetalle.Parameters("@CSol_UbiPiso").Value = Txt_Piso.Text.Trim

        Dim miParam7 As New SqlParameter("@CSol_UbiTelefono", SqlDbType.Char)
        miParam7.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam7)
        coDetalle.Parameters("@CSol_UbiTelefono").Value = Txt_Telefono.Text.Trim

        Dim miParam8 As New SqlParameter("@CSol_UbiExtension", SqlDbType.Char)
        miParam8.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam8)
        coDetalle.Parameters("@CSol_UbiExtension").Value = Txt_Extension.Text.Trim

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        If registro.Read Then
            vl_Respuesta = registro("CSol_ClavePres").ToString
            'MsgBox("Solicitud Creada", MsgBoxStyle.Information, "AppInsumos")
            Response.Write("<script>javascript: alert('Solicitud Creada: " & vl_Respuesta & "');<" & "/" & "script>")
            'Response.Write("<script>window.open('AppV_SolicitudNew.aspx',target='_self');<" & "/" & "script>")
            'Response.Redirect("index.html", False)
            Session("Vs_Clave") = registro("CSol_Clave").ToString
            Session("Vs_ClaveTexto") = registro("CSol_ClavePres").ToString
            Session("Vs_Secretaria") = DDL_Secretarias.Items(DDL_Secretarias.SelectedIndex).Text
            Session("Vs_TraeCve") = 0
            'Response.Write("<script>javascript: alert('Solicitud Creada: " & Session("Vs_Clave") & "');<" & "/" & "script>")
            Session("Vs_InsEstatus") = "S"
            Server.Transfer("AppC_SolicitudxCompras.aspx")
        Else
            MsgBox("Ocurrio un Error. Favor de contactar al Administrador del Sistema.", MsgBoxStyle.Critical, "AppInsumos")
        End If

        myConnection.Close()
    End Sub

    Protected Sub DDL_Secretarias_SelectedIndexChanged(sender As Object, e As EventArgs)

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
    <title>App Compras</title>
    <meta name="description" content="Aplicacion de Compras">
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

<body>
    <!-- Left Panel -->
    <aside id="left-panel" class="left-panel">
        <nav class="navbar navbar-expand-sm navbar-default">
            <div id="main-menu" class="main-menu collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active">
                        <a href="index_Compras.aspx"><i class="menu-icon fa fa-laptop"></i>Tablero </a>
                    </li>
                    <li class="menu-title">Compras</li><!-- /.menu-title -->
                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon fa fa-cogs"></i>Solicitudes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod1 = 1 And Vg_Fac1 < 3 Then %>
                            <li><i class="fa fa-id-card-o"></i><asp:HyperLink ID="HyperLink1" NavigateUrl ="AppC_SolicitudxNew.aspx" runat="server">Nueva</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod2 = 2 And Vg_Fac2 < 3 Then %>
                            <li><i class="ti-zoom-in"></i><asp:HyperLink ID="HyperLink2" NavigateUrl ="AppC_SolicitudXValidarE.aspx" runat="server">Por Validar E</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod3 = 3 And Vg_Fac3 < 3 Then %>
                            <li><i class="ti-pencil-alt"></i><asp:HyperLink ID="HyperLink3" NavigateUrl ="AppC_SolicitudXAprobarCE.aspx" runat="server">Por Aprobar CE</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod4 = 4 And Vg_Fac4 < 3 Then %>
                            <li><i class="ti-check"></i><asp:HyperLink ID="HyperLink4" NavigateUrl ="AppC_SolicitudxValidarC.aspx" runat="server">Por Validar C</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod5 = 5 And Vg_Fac5 < 3 Then %>
                            <li><i class="ti-check-box"></i><asp:HyperLink ID="HyperLink5" NavigateUrl ="AppC_SolicitudxAprobarSA.aspx" runat="server">Por Aprobar SA</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod6 = 6 And Vg_Fac6 < 3 Then %>
                            <li><i class="ti-money"></i><asp:HyperLink ID="HyperLink6" NavigateUrl ="AppC_SolicitudxComprar.aspx" runat="server">Por Comprar</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod7 = 7 And Vg_Fac7 < 3 Then %>
                            <li><i class="pe-7s-cart"></i><asp:HyperLink ID="HyperLink7" NavigateUrl ="AppC_SolicitudxSurtir.aspx" runat="server">Por Surtir</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod8 = 8 And Vg_Fac8 < 3 Then %>
                            <li><i class="ti-thumb-up"></i><asp:HyperLink ID="HyperLink8" NavigateUrl ="AppC_SolicitudxVoBo.aspx" runat="server">Por VoBo</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod9 = 9 And Vg_Fac9 < 3 Then %>
                            <li><i class="ti-email"></i><asp:HyperLink ID="HyperLink9" NavigateUrl ="AppC_SolicitudxNotificar.aspx" runat="server">Por Notificar</asp:HyperLink></li>
                            <% End If %>
                        </ul>
                    </li>

                    <li class="menu-title">Estadisticas</li><!-- /.menu-title -->

                    <li class="menu-item-has-children dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="menu-icon ti-files"></i>Reportes Solicitudes
                        </a>
                        <ul class="sub-menu children dropdown-menu">
                            <% If Vg_mod10 = 10 And Vg_Fac10 < 3 Then %>
                            <li><i class="ti-bookmark-alt"></i><asp:HyperLink ID="HyperLink12" NavigateUrl ="AppC_PorEstatus.aspx" runat="server">Por Estatus</asp:HyperLink></li>
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
                    <a class="navbar-brand" href="portal.aspx"><img src="images/logo4.png" alt="Logo"></a>
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

           <form id="form1" method = "post" runat="server" target="_self">

            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <strong class="card-title">Solicitudes / Nueva</strong>
                    </div>
                    <div class="card-body">
                        
                        <div class="col-lg-12 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong>Solicitud</strong>
                                </div>
                                <div class="card-body card-block">
                                    <!-- .table-stats -->
                                    <table class="table ">
                                        <tbody>
                                            <tr>
                                                <td colspan="3" width="99%">
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <label class=" form-control-label">Secretaria</label>
                                                            <div class="input-group">
                                                                <asp:DropDownList ID="DDL_Secretarias" OnSelectedIndexChanged="DDL_Secretarias_SelectedIndexChanged" class="form-control" runat="server"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Tipo de Solicitud</label>
                                                        <div class="input-group">
                                                            <asp:DropDownList ID="DDL_TipoSol" class="form-control" runat="server"></asp:DropDownList>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Unidad Presupuestal</label>
                                                        <div class="input-group">
                                                            <asp:DropDownList ID="DDL_UniPptal" class="form-control" runat="server"></asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Enlaces SFA</label>
                                                        <div class="input-group">
                                                            <asp:DropDownList ID="DDL_Enlaces" class="form-control" runat="server"></asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" width="99%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Objeto Partidista</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-th-large"></i></div>
                                                            <asp:TextBox ID="Txt_ObPartido" runat="server" Rows="2" class="form-control" TextMode="MultiLine"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Telefono</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-phone"></i></div>
                                                            <asp:TextBox ID="Txt_Telefono" runat="server"  MaxLength="10" class="form-control"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Extension</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-phone"></i></div>
                                                                <asp:TextBox ID="Txt_Extension" class="form-control" runat="server"  MaxLength="10"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td width="33%">
                                                    <div class="form-group">
                                                        <label class=" form-control-label">Edificio / Piso</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-building-o"></i></div>
                                                            <asp:TextBox ID="Txt_Edificio" runat="server"  MaxLength="80" class="form-control"></asp:TextBox>
                                                            <asp:TextBox ID="Txt_Piso" class="form-control"  MaxLength="30" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="33%">
                                                </td>
                                                <td width="33%" style="text-align:center">
                                                    <div class="form-group">
                                                        <asp:Button ID="Btn_Aceptar" OnClick="CSP_SetSolicitudNew" runat="server"  class="btn btn-success btn-sm" Text="Aceptar" />
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
                        <!-- /Solicitud -->
                        </div>

                      
                    </div>
                    <!-- .card-body -->
                </div>
                <!-- .card -->
            </div>
            <!-- .col-md-12 -->

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
