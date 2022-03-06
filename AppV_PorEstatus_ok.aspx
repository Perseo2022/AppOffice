<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="iso-8859-1" %>

<%@ Import Namespace="System" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.UI.Page" %>

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
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End If
        SP_GetPermiso()
        If Not Page.IsPostBack() Then
            'Obtienes Secretarias
            SP_GetSecretarias()

            VSP_GetolicitudTipo()

        End If
    End Sub

    Sub SP_GetPermiso()
        Dim vl_Respuesta As String = ""
        Dim myConnection As SqlConnection

        Try
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

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Sub SP_GetSecretarias()
        Dim myConnection As SqlConnection

        Try
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

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Sub VSP_GetolicitudTipo()
        Dim myConnection As SqlConnection

        Try
            myConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AppV").ToString)
            myConnection.Open()

            'Definir un SQLCommand, El nombre del Store Procedure en CommandText
            'El CommandType = StoreProcedure y la conexion
            Dim coDetalle As New SqlCommand
            coDetalle.CommandText = "AppV_SPGetSolicitudTipo"
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

            DDL_Estatus.DataTextField = "Sot_Descripcion"
            DDL_Estatus.DataValueField = "Sot_Clave"
            DDL_Estatus.DataSource = registro
            DDL_Estatus.DataBind()
            DDL_Estatus.Items.Insert(0, "Selecciona un Estatus")
            DDL_Estatus.SelectedIndex = 0

            registro.Close()
            myConnection.Close()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Sub SP_GetSolicitudxRepResumen()
        Dim myConnection As SqlConnection

        CleanCampos()
        Try
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
            If Not Txt_DateSol.Text.Trim.Equals("") Then
                Dim miParam As New SqlParameter("@vp_Mov_Fecha", SqlDbType.VarChar)
                miParam.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam)
                coDetalle.Parameters("@vp_Mov_Fecha").Value = Txt_DateSol.Text.Trim
            End If

            If Not Txt_DateFly.Text.Trim.Equals("") Then
                Dim miParam1 As New SqlParameter("@Sol_FechaVueloSalida", SqlDbType.VarChar)
                miParam1.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam1)
                coDetalle.Parameters("@Sol_FechaVueloSalida").Value = Txt_DateFly.Text.Trim
            End If

            If DDL_Secretarias.SelectedIndex > 0 Then
                Dim miParam4 As New SqlParameter("@vp_Sec_Clave", SqlDbType.Int)
                miParam4.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam4)
                coDetalle.Parameters("@vp_Sec_Clave").Value = CInt(DDL_Secretarias.Items(DDL_Secretarias.SelectedIndex).Value)
            End If

            If DDL_Estatus.SelectedIndex > 0 Then
                Dim miParam5 As New SqlParameter("@vp_SoT_Clave", SqlDbType.Int)
                miParam5.Direction = ParameterDirection.Input
                coDetalle.Parameters.Add(miParam5)
                coDetalle.Parameters("@vp_SoT_Clave").Value = CInt(DDL_Estatus.Items(DDL_Estatus.SelectedIndex).Value)
            Else
                Alert("Debes seleccionar un Estatus de la Solicitud")
                Exit Sub
            End If

            'ImageButton1.Enabled = True
            'MsgBox(DDL_Secretarias.Items(DDL_Secretarias.SelectedIndex).Value)

            daDetalle.Fill(dtTable)
            GV_Pasajero.DataSource = dtTable
            GV_Pasajero.DataBind()

            myConnection.Close()

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Protected Sub Alert(codigo As String)

        Response.Write("<script>window.alert('" & codigo & "');<" & "/" & "script>")

    End Sub

    Protected Sub GV_Pasajero_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Try

            'descarga(codigo);

            If (e.Row.RowType = DataControlRowType.Header) Then
                'e.Row.Cells(7).Visible = False
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
                e.Row.Cells(18).Visible = False
                'e.Row.Cells(19).Visible = False
                e.Row.Cells(20).Visible = False
                e.Row.Cells(0).Font.Size = 7
                e.Row.Cells(1).Font.Size = 7
                e.Row.Cells(2).Font.Size = 7
                e.Row.Cells(3).Font.Size = 7
                e.Row.Cells(4).Font.Size = 7
                e.Row.Cells(5).Font.Size = 7
                e.Row.Cells(6).Font.Size = 7
                e.Row.Cells(7).Font.Size = 7
                e.Row.Cells(19).Font.Size = 7
                e.Row.Cells(0).Text = "Sel"
                e.Row.Cells(1).Text = "Des"
                e.Row.Cells(2).Text = "No"
                e.Row.Cells(3).Text = "FECHA SOL"
                e.Row.Cells(4).Text = "NOMBRE"
                e.Row.Cells(5).Text = "PATERNO"
                e.Row.Cells(6).Text = "MATERNO"
                e.Row.Cells(7).Text = "VUELO"
                e.Row.Cells(19).Text = "CLAVE"

            End If
            If (e.Row.RowType = DataControlRowType.DataRow) Then
                'e.Row.Cells(7).Visible = False
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
                e.Row.Cells(18).Visible = False
                'e.Row.Cells(19).Visible = False
                e.Row.Cells(20).Visible = False
                e.Row.Cells(0).Font.Size = 7
                e.Row.Cells(1).Font.Size = 7
                e.Row.Cells(2).Font.Size = 7
                e.Row.Cells(3).Font.Size = 7
                e.Row.Cells(4).Font.Size = 7
                e.Row.Cells(5).Font.Size = 7
                e.Row.Cells(6).Font.Size = 7
                e.Row.Cells(7).Font.Size = 7
                e.Row.Cells(19).Font.Size = 7
            End If

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Protected Sub GV_Pasajero_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim row As GridViewRow = GV_Pasajero.SelectedRow
        'Dim col As GridView = GV_Pasajero.SelectedRow

        Try
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
            Txt_ClaveChar.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("Sol_Clave"))
            Txt_FechaSol.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("FechaSol"))
            Txt_TipoVuelo.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("VuT_Descripcion"))
            Txt_Estatus.Text = Convert.ToString(GV_Pasajero.DataKeys(row.RowIndex).Values("SoT_Descripcion"))
        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Sub CleanCampos()
        Try
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

        Catch ex As Exception
            Response.Write("<script>window.open('error.aspx',target='_self');<" & "/" & "script>")
        End Try

    End Sub

    Protected Sub GV_Pasajero_RowCommand(sender As Object, e As GridViewCommandEventArgs)

        If e.CommandName = "SelFile" Then
            Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument.ToString )

            'Reference the GridView Row.
            Dim row As GridViewRow = GV_Pasajero.Rows(rowIndex)

            'Fetch value of Country.
            Session("vs_Codigo") = row.Cells(19).Text

            'Session("vs_Codigo") = "Q5EKKA"
            'Response.Write("<script type='js/Vuelos.js'> descarga('Q5EKKA');<" & "/" & "script>")
            Response.Write("<script>window.open('FileDownload.aspx',target='_blank');<" & "/" & "script>")

        End If

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
                    <!--GEVS 24/03/2021-->
                    <!--<li class="menu-item-has-children dropdown">
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
                            <li><i class="ti-agenda"></i><asp:HyperLink ID="HyperLink11" NavigateUrl ="AppV_MensualxProveedor.aspx" runat="server">Mensual por Proveedor</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod9 = 9 And Vg_Fac9 < 3 Then %>
                            <li><i class="ti-bookmark-alt"></i><asp:HyperLink ID="HyperLink12" NavigateUrl ="AppV_PorEstatus.aspx" runat="server">Por Estatus</asp:HyperLink></li>
                            <% End If %>
                            <% If Vg_mod9 = 9 And Vg_Fac9 < 3 Then %>
                            <li><i class="ti-book"></i><asp:HyperLink ID="HyperLink30" NavigateUrl ="AppV_MesxProvxEjercicio.aspx" runat="server">Proveedor por Ejercicio</asp:HyperLink></li>
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
                            <a class="nav-link" href="./" onclick="<script> self.close(); </script>"><i class="fa fa-power -off"></i>Cerrar Sesión</a>
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
                            <strong class="card-title">Reportes / Por Estatus</strong>
                        </div>
                        <div class="card-body">

                            <div class="col-lg-12 col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                        <strong>Filtro de Busqueda</strong>
                                    </div>
                                    <div class="card-body card-block" >
                                        <!-- .table-stats -->
                                                    <div class="form-row">
                                                        <!--<div class="form-group col-md-4">
                                                            <label class=" form-control-label">Fecha de Solicitud</label>
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <input type="date" class="form-control" id="dateFechaFlyExit" >
                                                            </div>
                                                        </div>

                                                        <div class="form-group col-md-4">
                                                            <label class=" form-control-label">Fecha Vuelo </label>
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <input type="date" class="form-control" id="dateFechaFlyRet" >
                                                            </div>
                                                        </div>-->
                                                        <div class="form-group col-md-4">
                                                            <label class=" form-control-label">Estatus </label>
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <asp:DropDownList ID="DDL_Estatus" class="form-control" runat="server"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-row">
                                                        <div class="form-group col-md-9">
                                                            <div class="input-group">
                                                                <label class=" form-control-label">Secretaria</label>
                                                                <div class="input-group">
                                                                    <asp:DropDownList ID="DDL_Secretarias" class="form-control" runat="server"></asp:DropDownList>
                                                                </div>
                                                            </div>
                                                        </div>



                                                        <div class="form-group">
                                                            <div class="form-group col-md-3">
                                                                <div class="input-group">
                                                                    <label class=" form-control-label">Buscar</label>
                                                                    <div class="input-group">
                                                                        <asp:Button ID="Btn_Buscar" runat="server" Text="Ok" class="btn btn-success" OnClick="SP_GetSolicitudxRepResumen" />
                                                                        <asp:TextBox ID="Txt_SolClaveCon" runat="server" Visible="False"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-row">
                                                        <div class="form-group col-md-12">
                                                            <asp:GridView ID="GV_Pasajero" runat="server" Width="100%" OnRowDataBound="GV_Pasajero_RowDataBound" OnRowCommand="GV_Pasajero_RowCommand"
                                                                CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GV_Pasajero_SelectedIndexChanged"
                                                                DataKeyNames="No,FechaSol,Pas_Nombre,Pas_ApPaterno,Pas_ApMaterno,
                                                                            VuT_Descripcion,Sol_FechaVueloSalida, Sol_FechaVueloRegreso,
                                                                            Sol_HoraVueloSalida, Sol_HoraVueloRegreso, Sol_Origen, Sol_Destino,
                                                                            Aer_Descripcion, Sol_Reservacion, Sol_Costo,
                                                                            Sec_Descripcion, Age_Descripcion, Sol_Clave, SoT_Descripcion"
                                                                 ShowHeaderWhenEmpty="True" EmptyDataText="No se encontraron registros">

                                                                <Columns>
                                                                    <asp:CommandField ShowSelectButton="True" SelectText="Ok" ButtonType="Image" SelectImageUrl="~/images/Edit.jpg"></asp:CommandField>
                                                                </Columns>

                                                                <Columns>
                                                                    
                                                                    <asp:TemplateField headerText="Ok">
                                                                        <ItemTemplate>
                                                                            <asp:ImageButton CommandArgument="<%#Container.DataItemIndex %>" runat="server" Id ="SelFile" CommandName ="SelFile" ImageUrl="~/images/File.jpg" />
                                    
                                                                        </ItemTemplate>


                                                                    </asp:TemplateField>
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
                                                    </div>
                                        <!-- /.table-stats -->
                                    </div>
                                </div>
                            </div>

                        <!-- Solicitud -->
                        <div class="col-lg-12 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <strong>Solicitud: </strong> <asp:Label ID="Lbl_Datos" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="card-body card-block">
                                    <!-- .table-stats -->
                                                <div class="form-row">
                                                    <div class="form-group col-md-3">
                                                        <label class=" form-control-label">Clave Vuelo</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-key"></i></div>
                                                                    <asp:TextBox ID="Txt_ClaveChar" class="form-control" runat="server" MaxLength="10" disabled=""></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>


                                                    <div class="form-group col-md-3">
                                                        <label class=" form-control-label">Fecha Solicitud</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                    <asp:TextBox ID="Txt_FechaSol" class="form-control" runat="server" MaxLength="50" disabled=""></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-3">
                                                        <label class=" form-control-label">Tipo Vuelo</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-fighter-jet"></i></div>
                                                                    <asp:TextBox ID="Txt_TipoVuelo" class="form-control" runat="server" MaxLength="50" disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-3">
                                                        <label class=" form-control-label">Estatus</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-bell-o"></i></div>
                                                                    <asp:TextBox ID="Txt_Estatus" class="form-control" runat="server" MaxLength="50" disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Nombre</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                                                    <asp:TextBox ID="Txt_Nombre" class="form-control" runat="server" MaxLength="50" disabled=""></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>


                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Apellido Paterno</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                                                    <asp:TextBox ID="Txt_ApPaterno" class="form-control" runat="server" MaxLength="50" disabled=""></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Apellido Materno</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-user"></i></div>
                                                                    <asp:TextBox ID="Txt_ApMaterno" class="form-control" runat="server" MaxLength="50" disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Fecha Vuelo Salida</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <asp:TextBox ID="Txt_FechaVueloSal" class="form-control" runat="server" disabled=""></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Horario Vuelo Salida</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa ti-alarm-clock"></i></div>
                                                            <asp:TextBox ID="Txt_HourFlyExit" runat="server" class="form-control"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Fecha Vuelo Retorno</label>
                                                        <div class="input-group">
                                                            <div class="input-group">
                                                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                                                <asp:TextBox ID="TxtFechaVueloReg" class="form-control" runat="server" disabled=""></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Horario Vuelo Regreso</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa ti-alarm-clock"></i></div>
                                                            <asp:TextBox ID="Txt_HourFlyRet" runat="server"  class="form-control"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Origen</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-sign-in"></i></div>
                                                                <asp:TextBox ID="Txt_Origen" class="form-control" runat="server"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Destino</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-sign-out"></i></div>
                                                                <asp:TextBox ID="Txt_Destino" class="form-control" runat="server"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Aerolinea</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-plane"></i></div>
                                                            <asp:TextBox ID="Txt_Aerolinea" runat="server" class="form-control"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Reservacion</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-keyboard-o"></i></div>
                                                                <asp:TextBox ID="Txt_Reservacion" class="form-control" runat="server"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Costo</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-usd"></i></div>
                                                                <asp:TextBox ID="Txt_Costo" class="form-control" runat="server"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-8">
                                                        <label class=" form-control-label">Secretaria</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-building-o"></i></div>
                                                            <asp:TextBox ID="Txt_Secretaria" runat="server" class="form-control"  disabled=""></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="form-group col-md-4">
                                                        <label class=" form-control-label">Agencia</label>
                                                        <div class="input-group">
                                                            <div class="input-group-addon"><i class="fa fa-home"></i></div>
                                                                <asp:TextBox ID="Txt_Agencia" class="form-control" runat="server"  disabled=""></asp:TextBox>
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
                                            <asp:TextBox ID="Txt_DateSol" class="form-control" runat="server" MaxLength="10"></asp:TextBox>
                                            <asp:TextBox ID="Txt_DateFly" class="form-control" MaxLength="10" runat="server"></asp:TextBox>
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
                    <div class="col-sm-4 text-left">
                        <!--Copyright &copy; 2018 Empresa-->
                    </div>
                    <div class="col-sm-4 text-center">
                        <i class="fa fa-envelope"></i>
                        <asp:HyperLink ID="HyperLink16" NavigateUrl ="https://discord.gg/tdeNj3Bneh" runat="server">Contactanos</asp:HyperLink>
                    </div>
                    <div class="col-sm-4 text-right">
                        <!--Designed by <a href="smart.cen-pri.mx">Empresa</a>-->
                    </div>
                </div>
            </div>
        </footer>
        <!-- /.site-footer -->
    </div>
    <!-- /#right-panel -->
    <!-- Scripts -->
    <!-- Scripts -->

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

    <script src="https://cdn.jsdelivr.net/npm/moment@2.22.2/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@3.9.0/dist/fullcalendar.min.js"></script>
    <script src="assets/js/init/fullcalendar-init.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
    <script src="js/Vuelos.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            var now = new Date();

            var day = ("0" + now.getDate()).slice(-2);
            var month = ("0" + (now.getMonth() + 1)).slice(-2);

            //var today = (day) + "/" + (month) + "/" + now.getFullYear();
            var today = now.getFullYear() + "-" + (month) + "-" + (day);

            $("#dateFechaFlyExit").attr({ "min": today });


            $('#dateFechaFlyExit').change(function () {
                var fecha = new Date();
                var anio = fecha.getFullYear();

                var value = $(this).val();
                var vl_dia = new Date(value).getDate() + 1;
                var vl_mes = new Date(value).getMonth() + 1;
                var vl_anio = new Date(value).getFullYear();

                if (vl_dia.toString.length == 1) {
                    vl_dia = "0" + vl_dia;
                }

                if (vl_mes.toString.length == 1) {
                    vl_mes = "0" + vl_mes;
                }

                $("#Txt_DateSol").val(vl_dia + "/" + vl_mes + "/" + vl_anio);
                //alert($('#Txt_DateSol').val());

            });

            //$('#GV_Pasajero').on('RowCommand', 'tr td', function (evt) {
            //    var columna1 = $(#GV_Pasajero).parents("tr").find("td").eq(0).html();
            //    alert(columna1);
            //    var columna2 = $(this).parents("tr").find("td").eq(1).html();
            //    alert(columna2);
            //    if (columna1 == "File") {
            //        var codigo = $(#GV_Pasajero).parents("tr").find("td").eq(8).text();
            //        if ((codigo != "") & (codigo.length == 6)) {
            //            alert(codigo);
            //            descarga(codigo);
            //        }
            //    }
            //});

            //$('#GV_Pasajero').select.
            //$('#GV_Pasajero').on('click', 'tr', function () {
            //    var Name = $(this).find('td:first').text();
            //    alert(Name);
            //});

            $('#dateFechaFlyRet').change(function () {
                var value1 = $(this).val();
                var vl_dia1 = new Date(value1).getDate() + 1;
                var vl_mes1 = new Date(value1).getMonth() + 1;
                var vl_anio1 = new Date(value1).getFullYear();

                if (vl_dia1.toString.length == 1) {
                    vl_dia1 = "0" + vl_dia1;
                }

                if (vl_mes1.toString.length == 1) {
                    vl_mes1 = "0" + vl_mes1;
                }

                $('#Txt_DateFly').val(vl_dia1 + "/" + vl_mes1 + "/" + vl_anio1);
                //alert($('#Txt_DateFly').val());
            });

        });
    </script>
</body>
</html>
