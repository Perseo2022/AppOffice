using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de EventosDto
/// </summary>
public class EventosDto
{
	public EventosDto()
	{
	}
    public int EvtClave  { get; set; }
    public int IdArea { get; set; }
    public DateTime FechaInicio { get; set; }
    public string FechaInicio_S { get; set; }
    public DateTime FechaFin { get; set; }
    public string FechaFin_S { get; set; }
    public string Hora_Inicio { get; set; }
    public string Hora_Fin { get; set; }
    public int NumPersonas { get; set; }
    public int Lugar { get; set; }
    public int TipoMontaje { get; set; }
    public string NombreEvento { get; set; }
    public string Objetivo { get; set; }
    public int Estatus { get; set; }
    public List<Insumo_Eventos> listInsumos  { get; set; }
}