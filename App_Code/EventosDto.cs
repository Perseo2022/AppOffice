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
    public string NomLugar { get; set; }
    public int TipoMontaje { get; set; }
    public string NTipoMontaje { get; set; }
    public string NombreEvento { get; set; }
    public string Objetivo { get; set; }
    public string nameFile { get; set; }
    public string urlFile { get; set; }
    public string folioEvento { get; set; }
    public int Estatus { get; set; }

    public string UbiEdificio { get; set; }
    public string UbiPiso { get; set; }
    public string UbiTelefono { get; set; }
    public string UbiExtension { get; set; }

    public string SecDescripcion { get; set; }

    public string Observaciones { get; set; }

    public List<Insumo_Eventos> listInsumos  { get; set; }
}