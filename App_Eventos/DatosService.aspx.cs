﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using System.Web.Services;
public partial class App_Eventos_DatosService : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    private SqlConnection GetConexion()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString);
        con.Open();
        return con;
    }





    [WebMethod]
    public static int SaveEvento(EventosDto eventos)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("AppI_SPSetEventos"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter param;

                param = cmd.Parameters.Add("@Evt_Clave", SqlDbType.Int);
                param.Value = 0;
                param = cmd.Parameters.Add("@Id_Area", SqlDbType.Int);
                param.Value = eventos.IdArea;
                param = cmd.Parameters.Add("@Fecha_Inicio", SqlDbType.DateTime);
                param.Value = eventos.FechaInicio;
                param = cmd.Parameters.Add("@Fecha_Fin", SqlDbType.DateTime);
                param.Value = eventos.FechaFin;
                param = cmd.Parameters.Add("@Hora_Inicio", SqlDbType.VarChar, 20);
                param.Value = eventos.Hora_Inicio;
                param = cmd.Parameters.Add("@Hora_Fin", SqlDbType.VarChar, 20);
                param.Value = eventos.Hora_Fin;
                param = cmd.Parameters.Add("@Num_Personas", SqlDbType.Int);
                param.Value = eventos.NumPersonas;
                param = cmd.Parameters.Add("@Lugar", SqlDbType.Int);
                param.Value = eventos.Lugar;
                param = cmd.Parameters.Add("@Tipo_Montaje", SqlDbType.Int);
                param.Value = eventos.TipoMontaje;
                param = cmd.Parameters.Add("@Nombre_evento", SqlDbType.VarChar, 200);
                param.Value = eventos.NombreEvento;
                param = cmd.Parameters.Add("@Objetivo", SqlDbType.VarChar, 200);
                param.Value = eventos.Objetivo;

                param = cmd.Parameters.Add("@UbiEdificio", SqlDbType.VarChar, 80);
                param.Value = eventos.UbiEdificio;
                param = cmd.Parameters.Add("@UbiPiso", SqlDbType.VarChar, 30);
                param.Value = eventos.UbiPiso;
                param = cmd.Parameters.Add("@UbiTelefono", SqlDbType.VarChar, 10);
                param.Value = eventos.UbiTelefono;
                param = cmd.Parameters.Add("@UbiExtension", SqlDbType.VarChar, 10);
                param.Value = eventos.UbiExtension;
                param = cmd.Parameters.Add("@Observaciones", SqlDbType.VarChar, 150);
                param.Value = eventos.Observaciones;

                param = cmd.Parameters.Add("@Id_Evento", SqlDbType.Int);
                param.Direction = ParameterDirection.Output;
                cn.Open();

                cmd.ExecuteNonQuery();

                cn.Close();

                List<Insumo_Eventos> list = eventos.listInsumos;

                foreach (Insumo_Eventos insumo in list)
                {
                    insumo.IdEvento = (int)param.Value;
                    saveEventoInsumo(insumo);
                }

                return (int)param.Value;
            }
        }
    }

    [WebMethod]
    public static void saveEventoInsumo(Insumo_Eventos insumoEvento)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("AppI_SPSetInsumoEventos"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter param;

                param = cmd.Parameters.Add("@Evt_Clave", SqlDbType.Int);
                param.Value = insumoEvento.IdEvento;
                param = cmd.Parameters.Add("@Id_Insumo", SqlDbType.Int);
                param.Value = insumoEvento.IdInsumo;
                param = cmd.Parameters.Add("@UMedida", SqlDbType.Int);
                param.Value = insumoEvento.UMedida;
                param = cmd.Parameters.Add("@cantidad", SqlDbType.Int);
                param.Value = insumoEvento.Cantidad;
                cn.Open();

                cmd.ExecuteNonQuery();

                cn.Close();

            }
        }
    }

    [WebMethod]
    public static List<CatalogoDto> GetCatalogoTipo()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("AppI_SPGetProdCat"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.Text;
                cn.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    List<CatalogoDto> details = new List<CatalogoDto>();
                    foreach (DataRow dtRow in dt.Rows)
                    {
                        CatalogoDto Listado = new CatalogoDto();
                        Listado.ID = (int)dtRow["Cap_Clave"];
                        Listado.Descripcion = dtRow["CaP_Descripcion"].ToString();
                        details.Add(Listado);
                    }
                    return details;
                }
            }
        }
    }

    [WebMethod]
    public static List<CatalogoDto> GetInsumos(int IdInsumo)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("AppI_SPGetProducto"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter paramID = new SqlParameter();
                paramID.ParameterName = "@CaP_Clave";
                paramID.Value = IdInsumo;

                cmd.Parameters.Add(paramID);

                cn.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    List<CatalogoDto> details = new List<CatalogoDto>();
                    foreach (DataRow dtRow in dt.Rows)
                    {
                        CatalogoDto Listado = new CatalogoDto();
                        Listado.ID = (int)dtRow["Prod_Clave"];
                        Listado.Descripcion = dtRow["Prod_Descripcion"].ToString();
                        details.Add(Listado);
                    }
                    return details;
                }
            }
        }
    }


    [WebMethod]
    public static List<CatalogoDto> GetCatalogoLugares()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("AppE_SPGetLugares"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.Text;
                cn.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    List<CatalogoDto> details = new List<CatalogoDto>();
                    foreach (DataRow dtRow in dt.Rows)
                    {
                        CatalogoDto Listado = new CatalogoDto();
                        Listado.ID = (int)dtRow["Id_Lugar"];
                        Listado.Descripcion = dtRow["Descripcion"].ToString();
                        details.Add(Listado);
                    }
                    return details;
                }
            }
        }
    }

    [WebMethod]
    public static List<CatalogoDto> GetCatalogoTipoMontaje()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("AppE_SPGetTipoMontaje"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.Text;
                cn.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    List<CatalogoDto> details = new List<CatalogoDto>();
                    foreach (DataRow dtRow in dt.Rows)
                    {
                        CatalogoDto Listado = new CatalogoDto();
                        Listado.ID = (int)dtRow["Id_Montaje"];
                        Listado.Descripcion = dtRow["Descripcion"].ToString();
                        details.Add(Listado);
                    }
                    return details;
                }
            }
        }
    }



    [WebMethod]
    public static List<EventosDto> GetEventosByStatus(int IdStatus, string usuario) {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("AppE_SPGetEventos"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter paramID = new SqlParameter();
                paramID.ParameterName = "@Id_Status";
                paramID.Value = IdStatus;

                SqlParameter paramUser = new SqlParameter();
                paramUser.ParameterName = "@UsuAppV";
                paramUser.Value = usuario;

                cmd.Parameters.Add(paramID);
                cmd.Parameters.Add(paramUser);

                cn.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    List<EventosDto> details = new List<EventosDto>();
                    foreach (DataRow dtRow in dt.Rows)
                    {
                        EventosDto Listado = new EventosDto();
                        Listado.EvtClave = (int)dtRow["Evt_Clave"];
                        Listado.IdArea = (int)dtRow["Id_Area"];
                        Listado.FechaInicio_S = (string)dtRow["Fecha_Inicio"];// ((DateTime)dtRow[""]).ToString("dd/MM/yyyy HH:mm:ss");
                        Listado.FechaFin_S = dtRow["Fecha_Fin"].ToString();
                        Listado.Hora_Inicio = (string)dtRow["Hora_Inicio"];
                        Listado.Hora_Fin = (string)dtRow["Hora_Fin"];
                        Listado.NumPersonas = (int)dtRow["Num_Personas"];
                        Listado.Lugar = (int)dtRow["Lugar"];
                        Listado.TipoMontaje = (int)dtRow["Tipo_Montaje"];
                        Listado.NombreEvento = (string)dtRow["Nombre_evento"];
                        Listado.Objetivo = (string)dtRow["Objetivo"];
                        Listado.folioEvento = (string)dtRow["Cod_Solicitud"];
                        Listado.Estatus = (int)dtRow["Id_Estatus"];
                        Listado.SecDescripcion = (string)dtRow["Sec_Descripcion"];

                        details.Add(Listado);

                    }
                    return details;
                }
            }
        }
    }

    [WebMethod]
    public static EventosDto GetEventoById(int IdEvento)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("AppE_SPGetEventosBYId"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter paramID = new SqlParameter();
                paramID.ParameterName = "@Id_Evento";
                paramID.Value = IdEvento;
                cmd.Parameters.Add(paramID);
                cn.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    List<EventosDto> details = new List<EventosDto>();
                    EventosDto Listado = new EventosDto();
                    foreach (DataRow dtRow in dt.Rows)
                    {
                      
                        Listado.EvtClave = (int)dtRow["Evt_Clave"];
                        Listado.IdArea = (int)dtRow["Id_Area"];
                        Listado.FechaInicio_S = ((DateTime)dtRow["Fecha_Inicio"]).ToString("dd/MM/yyyy HH:mm:ss");
                        Listado.FechaFin_S = dtRow["Fecha_Fin"].ToString();
                        Listado.Hora_Inicio = (string)dtRow["Hora_Inicio"];
                        Listado.Hora_Fin = (string)dtRow["Hora_Fin"];
                        Listado.NumPersonas = (int)dtRow["Num_Personas"];
                        Listado.Lugar = (int)dtRow["Lugar"];
                        Listado.TipoMontaje = (int)dtRow["Tipo_Montaje"];
                        Listado.NombreEvento = (string)dtRow["Nombre_evento"];
                        Listado.Objetivo = (string)dtRow["Objetivo"];
                        Listado.Estatus = (int)dtRow["Id_Estatus"];
                        Listado.NomLugar = (string)dtRow["NLugar"];
                        Listado.NTipoMontaje = (string)dtRow["NTipoMontaje"];
                        Listado.nameFile =   (string)dtRow["File_Cotizacion"];
                        Listado.urlFile = HttpContext.Current.Request.Url.AbsoluteUri.Replace(HttpContext.Current.Request.Url.PathAndQuery, "/") + "/cotizacionEventos/" + (string)dtRow["File_Cotizacion"];
                        Listado.folioEvento = (string)dtRow["Cod_Solicitud"];
                        Listado.SecDescripcion = (string)dtRow["Sec_Descripcion"];
                    }
                    return Listado;
                }
            }
        }
    }

    [WebMethod]
    public static void UpdateStuatusEvento(int idEvento, int idStatus)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("AppE_SPUpdateStatusEvento"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter param;

                param = cmd.Parameters.Add("@Id_Evento", SqlDbType.Int);
                param.Value =idEvento;
                param = cmd.Parameters.Add("@Id_Estatus", SqlDbType.Int);
                param.Value = idStatus;
                cn.Open();
                cmd.ExecuteNonQuery();

                cn.Close();

            }
        }
    }

    [WebMethod]
    public static List<InsumoEvento> GetInsumosEvento(int IdEvento)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("AppE_SPGetInsumosEvent"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter paramID = new SqlParameter();
                paramID.ParameterName = "@Id_Evento";
                paramID.Value = IdEvento;
                cmd.Parameters.Add(paramID);
                cn.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    List<InsumoEvento> details = new List<InsumoEvento>();
                  
                    foreach (DataRow dtRow in dt.Rows)
                    {
                        InsumoEvento Listado = new InsumoEvento();
                        Listado.Codigo = (int)dtRow["Id_Insumo"];
                        Listado.Descripcion = (string)dtRow["Prod_Descripcion"];
                        Listado.UnidadMedida = (string)dtRow["UnM_Descripcion"];
                        Listado.Cantidad = (int)dtRow["Cantidad"];
                        details.Add(Listado);
                    }
                    return details;
                }
            }
        }
    }


    [WebMethod]
    public static string UpdateEvento(int idEvento, string fileName)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["AppV"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("AppE_SPUEventos"))
            {
                cmd.Connection = cn;
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter param;

                param = cmd.Parameters.Add("@Id_Evento", SqlDbType.Int);
                param.Value = idEvento;
                param = cmd.Parameters.Add("@NameFile", SqlDbType.VarChar);
                param.Value = fileName;
                cn.Open();
                cmd.ExecuteNonQuery();
                cn.Close();

                return "OK";
              
            }
        }
    }

}

