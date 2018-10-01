program tp3(input,output);  {Direccion de los archivos: C:\Tp-pascal\TP3.pas}
uses crt;
type

	gimnasio record 								{Declaracion de los registros para los archivos}
		nombre,direccion: String[30];
		valor-cuota: Real;
		valor-nutricionista: Real;
		valor-personal-trainer: Real;
	end;

	actividades record
		codigo-actividad: Integer;
		descripcion-actividad: String[30];
	end;

	dias-y-actividades record
		dia: Integer;
		hora: String[5];
		codigo-actividad: Integer;
	end;

	ejercicios-x-rutina record
		codigo-ejercicio: Integer;
		descripcion-rutina: String[30];
	end;

	clientes record
		dni: Integer;
		nombre-y-apellido: String[30];
		rutina-sn: Char;
		nutri-sn: Char;
		personal-sn: Char;
		pago-en-pesos_+_peso-actual: array[1..2,1..2] of Real;
	end;

	rutinasxclientes record
		dni: String[8];
		mes: Integer;
		anio: Integer;
		cantidad-repeticiones: array[1..4,1..50] of Integer;
		borrado-logico: Boolean;
	end;
var
	repet: cantidad-repeticiones;
	pagoypeso: pago-en-pesos_+_peso-actual;


begin
	{Menu/Programa princial}
end.
