function eventos(usuario, facultad) {
	loadTable();
	$('#DvDatos :input').attr('disabled', true);
	function loadTable() {
		$("#DvDatos").children().prop('disabled', true);
		//$("#DvDatos *").prop('disabled', true);
	$.ajax({
		type: "POST",
		url: "DatosService.aspx/GetEventosByStatus",
		data: JSON.stringify({ IdStatus: $("#IdStatusActual").val(), usuario: usuario }),
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function (data) {
			if (data != null) {
				var listCatalogoDto = data.d;
				$("#listaEventos tbody").empty();
				for (idx in listCatalogoDto) {
					var EventoDto = listCatalogoDto[idx];
					var thead = $('#listaEventos thead');
					thead.html('<tr><th>ID</th><th>Folio</th><th> Nombre </th><th> Fecha Inicio </th><th> Fecha Fin </th><th> Secretaria</th><th> Descarga</th></tr>');
					var tbody = $('#listaEventos tbody');
					var fila_nueva = $('<tr class="selectEvento" id=' + EventoDto.EvtClave + '></tr>');
					var tdIDInsumo = '<td>' + EventoDto.EvtClave + '</td>';
					var tdFolio = '<td>' + EventoDto.folioEvento + '</td>';
					var tdInsumo = '<td>' + EventoDto.NombreEvento + '</td>';
					var fecInicio = '<td>' + EventoDto.FechaInicio_S + '</td>';
					var fecFin = '<td>' + EventoDto.FechaFin_S + '</td>';
					var sec_Descripcion = '<td>' + EventoDto.SecDescripcion + '</td>';
					var download = '<td >  <img src="../images/download.png" class="descarga" alt="..."></td>';
					fila_nueva.append(tdIDInsumo);
					fila_nueva.append(tdFolio);
					fila_nueva.append(tdInsumo);
					fila_nueva.append(fecInicio);
					fila_nueva.append(fecFin);
					fila_nueva.append(sec_Descripcion);
					fila_nueva.append(download);
					tbody.append(fila_nueva);
					
				}
				
				$(".selectEvento").click(function () {
					//DowloadReport($(this).prop('id'));
					getObgetivobyId($(this).prop('id'), facultad);
					
				});

				$(".descarga").click(function () {
					var id = $(this).parent().parent().prop('id');
					var folio = $(this).parent().parent().find("td").eq(1).text();
					
					DowloadReport(id, folio);
				});

				var table = $('#listaEventos').DataTable();
				$('#listaEventos tbody').on('click', 'tr', function () {
					if ($(this).hasClass('selected')) {
						$(this).removeClass('selected');
					} else {
						table.$('tr.selected').removeClass('selected');
						$(this).addClass('selected');
					}
				});


			}
		}
	});
}

	function getObgetivobyId(id, facultad) {
		$.ajax({
			type: "POST",
			url: "DatosService.aspx/GetEventoById",
			data: JSON.stringify({ IdEvento: id }),
			//data: ,
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function (data) {
				if (data != null) {
					var EventoDto = data.d;
					$("#IdEvento").val(id);
					$("#nombre").val(EventoDto.NombreEvento);
					$("#numPersonas").val(EventoDto.NumPersonas);
					$("#Fecinicio").val(EventoDto.FechaInicio_S);
					$("#HoraInicio").val(EventoDto.Hora_Inicio);
					$("#FecFin").val(EventoDto.FechaFin_S);
					$("#HoraFin").val(EventoDto.Hora_Fin);
					$("#Objetivo").val(EventoDto.Objetivo);
					$("#NomLugar").val(EventoDto.NomLugar);
					$("#NTipoMontaje").val(EventoDto.NTipoMontaje);
					$("#nombreEvento").val(EventoDto.NombreEvento);
					if ($("#nameFile")[0]) {
						$("#nameFile").attr('href', EventoDto.urlFile);
						$("#fileName").text(EventoDto.nameFile);
					}
					if ($("#fileUpload")[0]) {
						$("#fileUpload").val(EventoDto.nameFile);
					}
					if (facultad == 1) {
						$('#BtnAceptar').attr("disabled", true);
						if ($("#BtnCargar")[0]) {
							$('#BtnCargar').attr("disabled", true);
						}

					}
					getInsumosEvento(id);
				}
			}
		});
	}
	$("#nameFile").click(function () {
		url = $(this).attr("href");
		window.open(url, "Cotizacion", "width=800,height=600,scrollbars=NO") 
		
		return false;
	});

	$("#viewDoc").click(function () {
		url = $("#nameFile").attr("href");
		window.open(url, "Cotizacion", "width=800,height=600,scrollbars=NO") 
		
		return false;
	});

	
	//listaInsumos
	function getInsumosEvento(idEvento) {
		$.ajax({
			type: "POST",
			url: "DatosService.aspx/GetInsumosEvento",
			data: JSON.stringify({ IdEvento: idEvento }),
			//data: ,
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function (data) {
				if (data != null) {
					var listCatalogoDto = data.d;
					$("#listaInsumos tbody").empty();
					for (idx in listCatalogoDto) {
						var Insumo = listCatalogoDto[idx];
						var tbody = $('#listaInsumos tbody');
						var fila_nueva = $('<tr class="selectEvento" id=' + Insumo.Codigo + '></tr>');
						var codigo = '<td>' + Insumo.Codigo + '</td>';
						var descripcion = '<td>' + Insumo.Descripcion + '</td>';
						var uMedida = '<td>' + Insumo.UnidadMedida + '</td>';
						var cantidad = '<td>' + Insumo.Cantidad + '</td>';
						fila_nueva.append(codigo);
						fila_nueva.append(descripcion);
						fila_nueva.append(uMedida);
						fila_nueva.append(cantidad);
						tbody.append(fila_nueva);

						/*
						 Listado.Codigo = (int)dtRow["Id_Insumo"];
                        Listado.Descripcion = (string)dtRow["Prod_Descripcion"];
                        Listado.UnidadMedida = (string)dtRow["UnM_Descripcion"];
                        Listado.Cantidad = (int)dtRow["Cantidad"];
						*/
					}
				}
			}
		});
	}

	$("#BtnAceptar").click(function () {
		
		$.ajax({
			type: "POST",
			url: "DatosService.aspx/UpdateStuatusEvento",
			data: JSON.stringify({ idEvento: $("#IdEvento").val(), idStatus :  $("#IdStatusActualizar").val() }),
			//data: ,
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function () {
				swal("Listo!!", "Evento Actualizado correctamente!", "success");
				loadTable();
			}
		});

	});

	function DowloadReport(codeEvento, folioEvento) {

		fileName = "Evento_"+folioEvento+".xlsx";
		$.ajax({
			type: "POST",
			url: "../ExcelSevice.aspx/CreateReporteEvent",
			data: '{idEvento: "' + codeEvento + '" }',
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function (r) {
				//Convert Base64 string to Byte Array.
				var bytes = Base64ToBytes(r.d);

				//Convert Byte Array to BLOB.
				var blob = new Blob([bytes], { type: "application/octetstream" });

				//Check the Browser type and download the File.
				var isIE = false || !!document.documentMode;
				if (isIE) {
					window.navigator.msSaveBlob(blob, fileName);
				} else {
					var url = window.URL || window.webkitURL;
					link = url.createObjectURL(blob);
					var a = $("<a />");
					a.attr("download", fileName);
					a.attr("href", link);
					$("body").append(a);
					a[0].click();
					$("body").remove(a);
				}
			}
		});

	};
	function Base64ToBytes(base64) {
		var s = window.atob(base64);
		var bytes = new Uint8Array(s.length);
		for (var i = 0; i < s.length; i++) {
			bytes[i] = s.charCodeAt(i);
		}
		return bytes;
	};


}