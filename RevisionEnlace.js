function eventos() {
	loadTable();
	function loadTable() { 
	$.ajax({
		type: "POST",
		url: "DatosService.aspx/GetEventosByStatus",
		data: JSON.stringify({ IdStatus: 2 }),
		//data: ,
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function (data) {
			if (data != null) {
				var listCatalogoDto = data.d;
				$("#listaEventos tbody").empty();
				for (idx in listCatalogoDto) {
					var EventoDto = listCatalogoDto[idx];
					var tbody = $('#listaEventos tbody');
					var fila_nueva = $('<tr class="selectEvento" id=' + EventoDto.EvtClave + '></tr>');
					var tdIDInsumo = '<td>' + EventoDto.EvtClave + '</td>';
					var tdInsumo = '<td>' + EventoDto.NombreEvento + '</td>';
					var fecInicio = '<td>' + EventoDto.FechaInicio_S + '</td>';
					var fecFin = '<td>' + EventoDto.FechaFin_S + '</td>';
					var numPersonas = '<td>' + EventoDto.NumPersonas + '</td>';
					fila_nueva.append(tdIDInsumo);
					fila_nueva.append(tdInsumo);
					fila_nueva.append(fecInicio);
					fila_nueva.append(fecFin);
					fila_nueva.append(numPersonas);
					tbody.append(fila_nueva);

				}

				$(".selectEvento").click(function () {
					//alert($(this).prop('id'));
					getObgetivobyId($(this).prop('id'));
				});

			}
		}
	});
}

	function getObgetivobyId(id) {

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
					$("#nombre").text(EventoDto.NombreEvento);
					$("#numPersonas").text(EventoDto.NumPersonas);
					$("#Fecinicio").text(EventoDto.FechaInicio_S);
					$("#FecFin").text(EventoDto.FechaFin_S);
					$("#Objetivo").text(EventoDto.Objetivo);
					
				}
			}
		});

	}

	$("#BtnAceptar").click(function () {
		
		$.ajax({
			type: "POST",
			url: "DatosService.aspx/UpdateStuatusEvento",
			data: JSON.stringify({ idEvento: $("#IdEvento").val(), idStatus : 3 }),
			//data: ,
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function () {
				swal("Listo!!", "Evento Actualizado correctamente!", "success");
				loadTable();
			}
		});

	});
}