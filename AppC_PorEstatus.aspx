<%@Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<%@Import Namespace = "System" %>
<%@Import Namespace="System.IO" %>
<%@Import Namespace = "System.Data" %>
<%@Import Namespace = "System.Data.OleDb" %>
<%@Import Namespace = "System.Data.SqlClient" %>

<script runat="server">
    Dim vg_Name As String = ""
    Dim vg_LastName As String = ""
    Dim vg_Clave As String = ""
    Dim Vg_InsClave As Integer
    Dim Vg_ClaveSol As Integer
    Dim Vg_ClaveSolPres As String
    Dim Vg_SecDescripcion As String

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
        'If Not Session("Vs_Clave").Equals(vbNull) Then

        'End If
        vg_Clave = Session("Vs_Clave")
        SP_GetPermiso()

        If Not Page.IsPostBack() Then
            SP_GetSecretarias()
            CSP_GetEstatus()
            'Btn_Guardar.Enabled = False
            ' Btn_Modificar.Enabled = False
        Else

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

    Sub CSP_GetEstatus()
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppC_SPGetEstatus"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        'Ejecutar el Store Procedure
        Dim registro As SqlDataReader = coDetalle.ExecuteReader

        DDL_Estatus.DataTextField = "CSot_Descripcion"
        DDL_Estatus.DataValueField = "CSot_Clave"
        DDL_Estatus.DataSource = registro
        DDL_Estatus.DataBind()
        DDL_Estatus.Items.Insert(0, "Selecciona un Estatus")
        DDL_Estatus.SelectedIndex = 0

        registro.Close()
        myConnection.Close()
    End Sub

    Sub CSP_GetSolicitudCompras()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppC_SPGetSolicitudCompras"
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

        Dim miParam2 As New SqlParameter("@CSol_ClavePres", SqlDbType.VarChar)
        miParam2.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam2)
        coDetalle.Parameters("@CSol_ClavePres").Value = Txt_Clave.Text.Trim

        If DDL_Estatus.SelectedIndex > 0 Then
            Dim miParam3 As New SqlParameter("@CSot_Clave", SqlDbType.Int)
            miParam3.Direction = ParameterDirection.Input
            coDetalle.Parameters.Add(miParam3)
            coDetalle.Parameters("@CSot_Clave").Value = CInt(DDL_Estatus.Items(DDL_Estatus.SelectedIndex).Value)
        End If

        daDetalle.Fill(dtTable)
        GV_Solicitud.DataSource = dtTable
        GV_Solicitud.DataBind()

        myConnection.Close()

    End Sub

    Sub CSP_GetCompras()
        Dim myConnection As SqlConnection

        'CleanFields()

        myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
        myConnection.Open()

        'Definir un SQLCommand, El nombre del Store Procedure en CommandText
        'El CommandType = StoreProcedure y la conexion
        Dim coDetalle As New SqlCommand
        coDetalle.CommandText = "AppC_SPGetCompras"
        coDetalle.CommandType = CommandType.StoredProcedure
        coDetalle.Connection = myConnection  'Previamente definida

        'El Adaptador y su SelectCommand
        Dim daDetalle As New SqlDataAdapter
        daDetalle.SelectCommand = coDetalle

        Dim dtTable As New DataTable

        'Parámetros si hubieran
        Dim miParam As New SqlParameter("@CSol_Clave", SqlDbType.Int)
        miParam.Direction = ParameterDirection.Input
        coDetalle.Parameters.Add(miParam)
        coDetalle.Parameters("@CSol_Clave").Value = CInt(Vg_ClaveSol)

        daDetalle.Fill(dtTable)
        GV_Compras.DataSource = dtTable
        GV_Compras.DataBind()


        myConnection.Close()

        'Response.Write("<script>javascript: document.getElementById('scrollmodal').style.display = 'block';<" & "/" & "script>")
    End Sub

    Protected Sub GV_Compras_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If (e.Row.RowType = DataControlRowType.Header) Then
            e.Row.Cells(4).Visible = False
            e.Row.Cells(5).Visible = False
            e.Row.Cells(6).Visible = False
            e.Row.Cells(7).Visible = False
            e.Row.Cells(8).Visible = False
            e.Row.Cells(0).Font.Size = 8
            e.Row.Cells(1).Font.Size = 8
            e.Row.Cells(2).Font.Size = 8
            e.Row.Cells(3).Font.Size = 8
            e.Row.Cells(0).Text = "Tipo de Producto"
            e.Row.Cells(1).Text = "Producto"
            e.Row.Cells(2).Text = "Unidad Medida"
            e.Row.Cells(3).Text = "Cantidad"
        End If
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            e.Row.Cells(4).Visible = False
            e.Row.Cells(5).Visible = False
            e.Row.Cells(6).Visible = False
            e.Row.Cells(7).Visible = False
            e.Row.Cells(8).Visible = False
            e.Row.Cells(0).Font.Size = 8
            e.Row.Cells(1).Font.Size = 8
            e.Row.Cells(2).Font.Size = 8
            e.Row.Cells(3).Font.Size = 8
        End If
    End Sub

    Protected Sub GV_Solicitud_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If (e.Row.RowType = DataControlRowType.Header) Then
            e.Row.Cells(5).Visible = False
            e.Row.Cells(6).Visible = False
            e.Row.Cells(7).Visible = False
            e.Row.Cells(8).Visible = False
            e.Row.Cells(9).Visible = False
            e.Row.Cells(10).Visible = False
            e.Row.Cells(11).Visible = False
            e.Row.Cells(0).Font.Size = 8
            e.Row.Cells(1).Font.Size = 8
            e.Row.Cells(2).Font.Size = 8
            e.Row.Cells(3).Font.Size = 8
            e.Row.Cells(4).Font.Size = 8
            e.Row.Cells(0).Text = "Sel"
            e.Row.Cells(1).Text = "Clave"
            e.Row.Cells(2).Text = "Secretaria"
            e.Row.Cells(3).Text = "Tipo"
            e.Row.Cells(4).Text = "Enlace"
        End If
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            e.Row.Cells(5).Visible = False
            e.Row.Cells(6).Visible = False
            e.Row.Cells(7).Visible = False
            e.Row.Cells(8).Visible = False
            e.Row.Cells(9).Visible = False
            e.Row.Cells(10).Visible = False
            e.Row.Cells(11).Visible = False
            e.Row.Cells(0).Font.Size = 8
            e.Row.Cells(1).Font.Size = 8
            e.Row.Cells(2).Font.Size = 8
            e.Row.Cells(3).Font.Size = 8
            e.Row.Cells(4).Font.Size = 8
        End If
    End Sub

    Protected Sub GV_Solicitud_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim row As GridViewRow = GV_Solicitud.SelectedRow

        Session("Vs_Clave") = Convert.ToString(GV_Solicitud.DataKeys(row.RowIndex).Values("CSol_Clave"))
        Vg_ClaveSol = Convert.ToString(GV_Solicitud.DataKeys(row.RowIndex).Values("CSol_Clave"))
        Session("Vs_ClaveTexto") = Convert.ToString(GV_Solicitud.DataKeys(row.RowIndex).Values("CSol_ClavePres"))
        Session("Vs_Secretaria") = Convert.ToString(GV_Solicitud.DataKeys(row.RowIndex).Values("Sec_Descripcion"))
        Session("Vs_FileCotizacion") = Convert.ToString(GV_Solicitud.DataKeys(row.RowIndex).Values("CSol_FileCotizacion"))
        Session("Vs_FileCompra") = Convert.ToString(GV_Solicitud.DataKeys(row.RowIndex).Values("CSol_FileCompra"))
        Session("Vs_TraeCve") = 1
        CSP_GetCompras()
    End Sub

    Protected Sub Btn_Modificar_Click(sender As Object, e As EventArgs)
        Server.Transfer("AppI_SolicitudxInsumos.aspx")
    End Sub

    Protected Sub DDL_Secretarias_SelectedIndexChanged(sender As Object, e As EventArgs)

        GV_Solicitud.DataSource = Nothing
        GV_Solicitud.DataBind()
        GV_Compras.DataSource = Nothing
        GV_Compras.DataBind()

    End Sub

    Protected Sub ImageButton2_Click(sender As Object, e As ImageClickEventArgs)
        Dim vl_Url As String = ""
        vl_Url = "CotCompras/" & Session("Vs_FileCotizacion")
        Response.Write("<script>window.open('" & vl_Url & "',target='_blank');<" & "/" & "script>")
    End Sub

    Protected Sub ImageButton1_Click(sender As Object, e As ImageClickEventArgs)
        Dim vl_Url As String = ""
        vl_Url = "CotCompras/" & Session("Vs_FileCompra")
        Response.Write("<script>window.open('" & vl_Url & "',target='_blank');<" & "/" & "script>")
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
                        <strong class="card-title">Reportes de Solicitudes / Por Estatus</strong>
                    </div>
                    <div class="card-body">
                        
                        <div class="col-lg-12 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong>Solicitud Clave: <%=Session("Vs_ClaveTexto") & "  " %></strong>
                                </div>
                                <div class="card-body card-block">
                                    <!-- .table-stats -->
                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                                            <div class="input-group">
                                                <label class=" form-control-label">Secretaria</label>
                                                <div class="input-group">
                                                    <asp:DropDownList ID="DDL_Secretarias" class="form-control" runat="server" OnSelectedIndexChanged="DDL_Secretarias_SelectedIndexChanged"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group col-md-3">
                                            <div class="input-group">
                                                <label class=" form-control-label">Estatus</label>
                                                <div class="input-group">
                                                    <asp:DropDownList ID="DDL_Estatus" class="form-control" runat="server"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group col-md-3">
                                            <label for="input-small" class=" form-control-label">Clave</label>
                                            <div class="input-group">
                                                <div class="input-group-addon"><i class="fa fa-key"></i></div>
                                                <asp:TextBox ID="Txt_Clave" runat="server"  MaxLength="6"  class="form-control"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="form-group col-md-2">
                                            <label for="input-small" class=" form-control-label">Buscar</label>
                                            <div class="input-group">
                                                <asp:Button ID="Btn_Aceptar" OnClick="CSP_GetSolicitudCompras"  runat="server" class="btn btn-warning" Text="Ok"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                            <asp:GridView ID="GV_Solicitud" runat="server" Width="100%" OnRowDataBound="GV_Solicitud_RowDataBound"
                                                CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GV_Solicitud_SelectedIndexChanged"
                                                DataKeyNames="CSol_ClavePres,CSol_Clave,Sec_Clave,CSot_Clave,InT_Clave,IEn_Clave,Sec_Descripcion , CSol_FileCotizacion ,CSol_FileCompra">
                                                <AlternatingRowStyle BackColor="White" ForeColor="#284775"></AlternatingRowStyle>

                                                <Columns>
                                                    <asp:CommandField ShowSelectButton="True" SelectText="Ok" ButtonType="Image" SelectImageUrl="~/images/Edit.jpg"></asp:CommandField>

                                                </Columns>

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
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group">
                                            <div class="input-group">
                                                <label class=" form-control-label">Productos:</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                            <asp:GridView ID="GV_Compras" runat="server" Width="100%" OnRowDataBound="GV_Compras_RowDataBound"
                                                CellPadding="4" ForeColor="#333333" GridLines="None" 
                                                DataKeyNames="Com_Clave,Prod_Clave, CSol_Clave, UnM_Clave">
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
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                                            <label class=" form-control-label">Abrir Cotización</label>
                                            <div class="input-group">
                                                <asp:ImageButton ID="ImageButton2" ImageUrl="~/images/Ver.jpg" OnClick="ImageButton2_Click" Width="30px" Height="30px" runat="server" />
                                            </div>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <label class=" form-control-label">Abrir Formato</label>
                                            <div class="input-group">
                                                <asp:ImageButton ID="ImageButton3" ImageUrl="~/images/Ver.jpg"  Width="30px" Height="30px" runat="server" />
                                            </div>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <label class=" form-control-label">Abrir Recibo</label>
                                            <div class="input-group">
                                                <asp:ImageButton ID="ImageButton1" ImageUrl="~/images/Ver.jpg" OnClick="ImageButton1_Click" Width="30px" Height="30px" runat="server" />
                                            </div>
                                        </div>
                                    </div>
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

       <link href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" rel="stylesheet" />
     <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
    <script src="js/ReporteCompras.js"></script>

</body>
</html>
