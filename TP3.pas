program tp3(input,output);  {Direccion de los archivos: C:\Tp-pascal\TP3.pas}
uses crt, sysutils;
type
    pp = array[1..12,1..2] of Real;
    cantrep = array[1..4,1..50] of Integer;

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
		dni: string[8];
		nombre_y_apellido: String[30];
		rutina_sn: Char;
		nutri_sn: Char;
		personal_sn: Char;
		pago_en_pesos_y_peso_actual:pp;
	end;

	rutinas_x_clientes = record
		dni: String[8];
		mes: Integer;
		anio: Integer;
		cantidad_repeticiones: cantrep;
		borrado_logico: Boolean;
	end;

var
    {registros}
    g:gimnasio;
    a:actividades;
    dyhreg:dias_y_horarios;
    exrreg:ejercicios_x_rutina;
    c:clientes;
    rxcreg:rutinas_x_clientes;
    busqueda:integer;

    {archivos}
    gim: file of gimnasio;
    act: file of actividades;
    dyh: file of dias_y_horarios;
    exr: file of ejercicios_x_rutina;
    cli: file of clientes;
    rxc: file of rutinas_x_clientes;

function secuencial_cli(a:string):integer;
begin
     if filesize(cli)=0 then
        secuencial_cli:=-1
     else
         begin
              seek(cli,0);
              repeat
                    read(cli,c);
              until eof(cli) or (a=c.dni);
              if a=c.dni then
                 secuencial_cli:=filepos(cli)-1
              else
                  secuencial_cli:=-1;
         end;
end;
{==============================================================================ABM================================================================================}
procedure ABM;
var
    op,i: Integer;
begin

    clrscr;
    writeln('Menu de ABM');
    writeln('¿Que archivo desea utilizar?');
    writeln('1) Gimnasio');
    writeln('2) Actividades');
    writeln('3) Dias y Horarios');
    writeln('4) Ejercicios por Rutinas');
    writeln('5) Volver');

    repeat
       readln(op);
    until (op >=1) and (op <=5);

    while op <> 5 do
      begin
          case op of
             1: begin
                   writeln('¿Quiere crear/abrir el archivo o quiere modificar algun campo?');
                   writeln('1) Dar de alta gimnasio');
                   writeln('2) Modificar datos del gimnasio');
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
                         writeln();
                         writeln('                         Datos de gimnasio agregados con exito!');
                         write(gim,g);
                         readkey;
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

                   write(act,a);
                end;

             3:  begin
                    if filesize(dyh) = 6 then
                    begin
                       writeln('El archivo dias y horarios ya esta completado');
                       readkey;
                    end
                    else
                    begin
                        for i:= 1 to 6 do
                        begin
                            writeln('Ingrese la hora del dia ',i);
                            readln(dyhreg.hora);
                            writeln('Ingrese el codigo de la actividad');
                            repeat
                                  readln(dyhreg.codigo_actividad);
                            until dyhreg.codigo_actividad > 0;
                            writeln();
                            write(dyh,dyhreg);
                            writeln('Datos del dia ',i,' guardados correctamente');
                            writeln(filesize(dyh));
                            readkey;
                        end;
                    end;
                 end;

             4:  begin
                    writeln('Ingrese el codigo de ejercicio');
                    repeat
                          readln(exrreg.codigo_ejercicio);
                    until exrreg.codigo_ejercicio > 0;
                    writeln('Ingrese la descripcion de la rutina');
                    readln(exrreg.descripcion_rutina);

                    write(exr,exrreg);
                end;
          end;

          clrscr;
          writeln('Menu de ABM');
          writeln('¿Que archivo desea utilizar?');
          writeln('1) Gimnasio');
          writeln('2) Actividades');
          writeln('3) Dias y Horarios');
          writeln('4) Ejercicios por Rutinas');
          writeln('5) Volver');
          repeat
             readln(op);
          until (op >=1) and (op <= 4);
      end;
end;

{============================================================================= CLIENTES ============================================================================}

procedure CLIENT();
var
   yy,mm,dd:word;
   mes,anio:integer;
   deuda:char;
   dni:string[8];
   cuota:real;
begin
     decodedate(date,yy,mm,dd);
     mes:=mm;
     anio:=yy;
     clrscr;
     if filesize(gim)<0 then
     begin
          read(gim,g);
     end;
     writeln('Ingrese el DNI: ');
     readln(dni);
     {writeln('Filesize: ', filesize(cli));}
     busqueda:=secuencial_cli(dni);
     {writeln('Filesize actual ',filesize(cli));
     writeln('Secuencial: ', busqueda);}
     if busqueda > -1 then                                {Si la busqueda devuelve mas de 0, quiere decir que se encontro el cliente}
     begin
          if c.pago_en_pesos_y_peso_actual[mes,1] = 0 then                   {Si esta condicion es verdadera, significa que debe este mes}
          begin
               writeln('Usted debe el mes actual');                            {Se le consultan datos nuevamente y se verifica si desea pagar el mes o no}
               writeln('Desea solicitar una rutina (S/N): ');
               repeat
                     readln(c.rutina_sn);
               until (c.rutina_sn='s') or (c.rutina_sn='n');
               writeln('Desea solicitar un Personal Trainer? (S/N): ');
               repeat
                     readln(c.personal_sn);
               until (c.personal_sn='s') or (c.personal_sn='n');
               writeln('Desea pagar el mes actual? (S/N)');
               repeat
                     readln(deuda);
               until (deuda='s') or (deuda='n');
               if deuda = 's' then
               begin
                    if c.rutina_sn='s' then
                    begin
                         cuota:=cuota+g.valor_cuota;
                    end;
                    if c.personal_sn='s' then
                    begin
                         cuota:=cuota+g.valor_personal_trainer;
                    end;
                    cuota:=cuota+g.valor_cuota;
                    c.pago_en_pesos_y_peso_actual[mes,1]:=cuota;
                    writeln('El pago fue realizado con exito!');
                    readkey;
               end;

          end;
          if c.pago_en_pesos_y_peso_actual[mes,1] > 0 then
          begin
               writeln('El cliente no adeuda este mes');
               readkey;
          end;
     end;
     if busqueda = -1 then
     begin
          clrscr;
          writeln('El cliente con DNI ( ',dni,' ) no pertenece a nuestros clientes');
          writeln();
          writeln('Para continuar, Detalle los siguientes datos a continuacion: ');
          writeln('Ingrese el nombre y el apellido: ');
          readln(c.nombre_y_apellido);
          writeln('Desea solicitar una rutina (S/N): ');
          repeat
                readln(c.rutina_sn);
          until (c.rutina_sn='s') or (c.rutina_sn='n');
          if c.rutina_sn='s' then
          begin
               rxcreg.mes:=mes;
               rxcreg.anio:=anio;
               rxcreg.dni:=dni;
          end;
          writeln('Desea solicitar un Personal Trainer? (S/N): ');
          repeat
                readln(c.personal_sn);
          until (c.personal_sn='s') or (c.personal_sn='n');
          if c.rutina_sn='s' then
          begin
               cuota:=cuota+g.valor_cuota;
          end;
          if c.personal_sn='s' then
          begin
               cuota:=cuota+g.valor_personal_trainer;
          end;
          cuota:=cuota+g.valor_cuota;
          c.pago_en_pesos_y_peso_actual[mes,1]:=cuota;
          writeln('El pago fue realizado con exito!');
          readkey;
     end;
     rxcreg.borrado_logico:=false;
     c.dni:=dni;
     write(cli,c);
     write(rxc,rxcreg);
end;

{============================================================================= RUTINAS ============================================================================}

procedure RUTINAS();
var
dni:string[8];
busqueda,mes,act,i,rep:integer;
pact:real;
op:char;
begin
     clrscr;
     pact:=0;
     mes:=0;
     if filesize(cli)>0 then
     begin
          read(cli,c);
     end;
     write('Ingrese DNI del cliente: ');
     readln(dni);
     busqueda:=secuencial_cli(dni);
     if filesize(rxc)=0 then
     begin
          read(rxc,rxcreg);
     end;
     seek(rxc,busqueda);
     seek(cli,busqueda);
     if (busqueda>=0) and (rxcreg.borrado_logico=false) then
     begin
          write('Mes: ');
          repeat
                readln(rxcreg.mes);
          until (rxcreg.mes>0) and (rxcreg.mes<7);
          write('Año: ');
          repeat
                readln(rxcreg.anio);
          until (rxcreg.anio<2100)and(rxcreg.anio>2000);
          repeat
          begin
               clrscr;
               writeln('Se ha encontrado el cliente. (DNI: ',dni,')');
               write('Ingrese actividad: ');
               repeat
                     readln(act);
               until (act<=50) and (act>=0);
               for i:=1 to 4 do
               begin
                    clrscr;
                    writeln('Acitividad: ',act);
                    writeln('Serie: ',i);
                    write('Ingrese cantidad de repeticiones: ');
                    readln(rep);
                    rxcreg.cantidad_repeticiones[act,i]:=rep;
               end;
          write('Desea agregar otra actividad? (S/N:) ');
          repeat
                readln(op);
          until(op='n') or (op='s');
          end;
          until op='n';
          writeln('Debe actualizar el peso del cliente: ',c.pago_en_pesos_y_peso_actual[mes,2]:5:3,' Kg');
          repeat
                readln(pact);
          until pact>0;
          c.pago_en_pesos_y_peso_actual[mes,2]:= pact;

     end;
     if busqueda<0 then
     begin
          writeln('El cliente no existe, debe crearlo primero');
          readkey;
     end;
     write(rxc,rxcreg);
     write(cli,c);
     
end;

{============================================================================= LISTADO ============================================================================}

{procedure LISTADO();
var i,verif: integer;
begin
     clrscr;
     if filesize(gim) > 0 then
     begin
        read(gim,g);
        writeln('Datos del Gimnasio');
        writeln('    Nombre: ',g.nombre);
        writeln('    Cuota: $',g.valor_cuota);
        writeln('    Nutricionista: $',g.valor_nutricionista);
        writeln('    Personal Trainer: $',g.valor_personal_trainer);
        writeln();
     end
     else
         writeln('No hay datos del gimnasio');
          read(dyh,dyhreg);
          seek(dyh,0);
          if filesize(dyh) = 0 then
          begin
               writeln('No hay informacion de dias y horarios');
               readkey;
          end
          else
          begin
               readkey;
               read(act,a);
               if filesize(act) = 0 then
                  verif:= 0
               else
                  verif:= 1;

               for i:= 0 to filesize(dyh) -1 do
               begin
                    case i of
                        0: begin
                                seek(dyh,i);
                                writeln('Dia: Lunes');
                                writeln('Hora: ',dyhreg.hora);

                                if verif = 0 then
                                   writeln('Actividad: No hay informacion acerca de la actividad de este dia')
                                else
                                begin
                                    seek(act,(dyhreg.codigo_actividad - 1));
                                    writeln('Actividad: ',a.descripcion_actividad);
                                end;
                           end;
                        1: begin

                                writeln('Dia: Martes');
                                seek(dyh,(i-1));
                                writeln('Hora: ',dyhreg.hora);
                                if verif = 0 then
                                   writeln('Actividad: No hay informacion hacerca de la actividad de este dia')
                                else
                                begin
                                    seek(act,(dyhreg.codigo_actividad - 1));
                                    writeln('Actividad: ',a.descripcion_actividad);
                                end;
                           end;
                        2: begin
                                seek(dyh,(i-1));
                                writeln('Dia: Miercoles');
                                writeln('Hora: ',dyhreg.hora);
                                if verif = 0 then
                                   writeln('Actividad: No hay informacion hacerca de la actividad de este dia')
                                else
                                begin
                                    seek(act,(dyhreg.codigo_actividad - 1));
                                    writeln('Actividad: ',a.descripcion_actividad);
                                end;
                           end;
                        3: begin
                                seek(dyh,(i-1));
                                writeln('Dia: Jueves');
                                writeln('Hora: ',dyhreg.hora);
                                if verif = 0 then
                                   writeln('Actividad: No hay informacion hacerca de la actividad de este dia')
                                else
                                begin
                                    seek(act,(dyhreg.codigo_actividad - 1));
                                    writeln('Actividad: ',a.descripcion_actividad);
                                end;
                           end;
                        4: begin
                                seek(dyh,(i-1));
                                writeln('Dia: Viernes');
                                writeln('Hora: ',dyhreg.hora);
                                if verif = 0 then
                                   writeln('Actividad: No hay informacion hacerca de la actividad de este dia')
                                else
                                begin
                                    seek(act,(dyhreg.codigo_actividad - 1));
                                    writeln('Actividad: ',a.descripcion_actividad);
                                end;
                           end;
                        5: begin
                                seek(dyh,(i-1));
                                writeln('Dia: Sabado');
                                writeln('Hora: ',dyhreg.hora);
                                if verif = 0 then
                                   writeln('Actividad: No hay informacion hacerca de la actividad de este dia')
                                else
                                begin
                                    seek(act,(dyhreg.codigo_actividad - 1));
                                    writeln('Actividad: ',a.descripcion_actividad);
                                end;
                           end;
                    end;
               end;
          end;
       end;
       begin
       end;

end;   }


procedure RECAUDACION();
var
mes,i:integer;
recaudado:real;
begin
     clrscr;
     if filesize(cli)>0 then
     begin
          recaudado:=0;
          writeln('Ingrese el numero mes deseado: ');
          repeat
                readln(mes);
          until (mes>0) and (mes<13);
          read(cli,c);
          for i:=1 to filesize(cli)-1 do
          begin
               seek(cli,i);
               recaudado:=recaudado+c.pago_en_pesos_y_peso_actual[mes,1];
          end;
          writeln('Lo recaudado en el mes ',mes,' es: ', recaudado:5:2);
          readkey();
     end
     else
     begin
          writeln('No existen registro de ese mes');
          readkey;
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
             1: ABM();
             2: CLIENT();
             3: RUTINAS();
             4: {LISTADO()}writeln('hola');
             5: RECAUDACION();
          end;
          clrscr;
          writeln('Menu de opciones');
          writeln('1) ABM');
          writeln('2) Clientes');
          writeln('3) Rutinas por clientes');
          writeln('4) Listado de dias y horarios');
          writeln('5) Recaudacion');
          writeln('6) Reiniciar (blanqueo)');

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
