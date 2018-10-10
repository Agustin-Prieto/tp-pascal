program tp3(input,output);  {Direccion de los archivos: C:\Tp-pascal\TP3.pas}
uses crt, sysutils;
type
    pago_en_pesos_y_peso_actual = array[1..2,1..2] of Real;
    cantidad_repeticiones = array[1..4,1..50] of Integer;

	gimnasio = record 								{Declaracion de los registros para los archivos}
		nombre: String[30];
        direccion: String[30];
		valor_cuota: Real;
		valor_nutricionista: Real;
		valor_personal_trainer: Real;
	end;

	actividades = record
		codigo_actividad: Integer;
		descripcion_actividad: String[30];
	end;

	dias_y_horarios = record
		dia: Integer;
		hora: String[5];
		codigo_actividad: Integer;
	end;

	ejercicios_x_rutina = record
		codigo_ejercicio: Integer;
		descripcion_rutina: String[30];
	end;

	clientes = record
		dni: Integer;
		nombre_y_apellido: String[30];
		rutina_sn: Char;
		nutri_sn: Char;
		personal_sn: Char;
		pago_en_pesos_y_peso_actual: pago_en_pesos_y_peso_actual;
	end;

	rutinas_x_clientes = record
		dni: String[8];
		mes: Integer;
		anio: Integer;
		cantidad_repeticiones: cantidad_repeticiones;
		borrado_logico: Boolean;
	end;

var
	repet: cantidad_repeticiones;
	pagoypeso: pago_en_pesos_y_peso_actual;

    {registros}
    g:gimnasio;
    a:actividades;
    dyhreg:dias_y_horarios;
    exrreg:ejercicios_x_rutina;
    c:clientes;
    rxcreg:rutinas_x_clientes;

    {archivos}
    gim: file of gimnasio;
    act: file of actividades;
    dyh: file of dias_y_horarios;
    exr: file of ejercicios_x_rutina;
    cli: file of clientes;
    rxc: file of rutinas_x_clientes;

procedure ABM;
var
    op: Integer;
begin

    clrscr;
    writeln('Menu de ABM');
    writeln('¿Que archivo desea utilizar?');
    writeln('1) Gimnasio');
    writeln('2) Actividades');
    writeln('3) Dias y Horarios');
    writeln('4) Ejercicios por Rutinas');

    repeat
       readln(op);
    until (op >=1) and (op <=4);

    while op <> 5 do
      begin
          case op of
             1: begin
                   writeln('¿Quiere crear/abrir el archivo o quiere modificar algun campo?');
                   writeln('1) Dar de alta nuevo cliente');
                   writeln('2) Modificar datos del cliente');
                   repeat
                        readln(op);
                   until (op >= 1) and (op <= 2);
                   if op = 1 then
                      begin
                         writeln('Ingrese el nombre');
                         readln(g.nombre);
                         writeln('Ingrese la direccion');
                         readln(g.direccion);
                         writeln('Ingrese el valor de la cuota');
                         repeat
                               readln(g.valor_cuota);
                         until (g.valor_cuota > 0);
                         writeln('Ingrese el valor del nutricionista');
                         repeat
                               readln(g.valor_nutricionista);
                         until g.valor_nutricionista > 0;
                         writeln('Ingrese el valor del personal trainer');
                         repeat
                               readln(g.valor_personal_trainer);
                         until g.valor_nutricionista > 0;

                         seek(gim,filesize(gim));
                         write(gim,g);

                      end
                   else
                      begin  {terminar}
                         writeln('Ingrese un nuevo valor para el valor de la cuota');
                         writeln('Ingrese un nuevo valor para el valor del nutricionista');
                         writeln('Ingrese un nuevo valor para el valor del personal trainer');
                      end;
                end;

             2: begin
                   writeln('Ingrese el codigo de la actividad');
                   repeat
                   readln(a.codigo_actividad);
                   until a.codigo_actividad > 0;
                   writeln('Ingrese la descripcion de la actividad');
                   readln(a.descripcion_actividad);

                   seek(gim,filesize(act));
                   write(act,a);
                end;

             3:  begin
                    writeln('Ingrese el dia');
                    repeat
                          readln(dyhreg.dia);
                    until dyhreg.dia > 0;
                    writeln('Ingrese la hora');
                    readln(dyhreg.hora);
                    writeln('Ingrese el codigo de la actividad');
                    repeat
                          readln(dyhreg.codigo_actividad);
                    until dyhreg.codigo_actividad > 0;

                    seek(dyh,filesize(dyh));
                    write(dyh,dyhreg);
                 end;
             4:  begin
                    writeln('Ingrese el codigo de ejercicio');
                    repeat
                          readln(exrreg.codigo_ejercicio);
                    until exrreg.codigo_ejercicio > 0;
                    writeln('Ingrese la descripcion de la rutina');
                    readln(exrreg.descripcion_rutina);

                    seek(exr,filesize(exr));
                    write(exr,exrreg);
                end;
          end;

          repeat
             readln(op);
          until (op >=1) and (op <= 4);
      end;
end;

procedure menu;
var
   op:Integer;
begin
    writeln('Menu de opciones');
    writeln('1) ABM');
    writeln('2) Clientes');
    writeln('3) Rutinas por clientes');
    writeln('4) Listado de dias y horarios');
    writeln('5) Recaudacion');
    writeln('6) Reiniciar (blanqueo)');

    repeat
       readln(op);
    until (op >=1) and (op <=6);

    while op <> 7 do
      begin
          case op of
             1: ABM;
             2: writeln('Texto de prueba');
             3: writeln('Texto de prueba');
             4: writeln('Texto de prueba');
             5: writeln('Texto de prueba');
             6: writeln('Texto de prueba');
          end;

          repeat
             readln(op);
          until (op >=1) and (op <= 6);
      end;
end;

begin
     assign(gim,'C:\TP3\gimnasio.dat');
     {$I-}
     reset(gim);
     if ioresult = 2 then
        rewrite(gim);
     {$I+}

     assign(act,'C:\TP3\actividades.dat');
     {$I-}
     reset(act);
     if ioresult = 2 then
        rewrite(act);
     {$I+}

     assign(dyh,'C:\TP3\dias_y_horarios.dat');
     {$I-}
     reset(dyh);
     if ioresult = 2 then
        rewrite(dyh);
     {$I+}

     assign(exr,'C:\TP3\ejercicios_x_rutinas.dat');
     {$I-}
     reset(exr);
     if ioresult = 2 then
        rewrite(exr);
     {$I+}

     assign(cli,'C:\TP3\clientes.dat');
     {$I-}
     reset(cli);
     if ioresult = 2 then
        rewrite(cli);
     {$I+}

     assign(rxc,'C:\TP3\rutinas_x_clientes.dat');
     {$I-}
     reset(rxc);
     if ioresult = 2 then
        rewrite(rxc);
     {$I+}
	{Menu/Programa princial}
    menu;
    readkey
end.
