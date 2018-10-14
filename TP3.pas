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

    repeat
       readln(op);
    until (op >=1) and (op <=5);

    while op <> 5 do
      begin
          case op of
             1: begin
                   clrscr;
                   writeln('¿Quiere crear/abrir el archivo o quiere modificar algun campo?');
                   writeln('1) Dar de alta al nuevo gimnasio');
                   writeln('2) Modificar datos del gimnasio');
                   repeat
                        readln(op);
                   until (op >= 1) and (op <= 2);
                   if op = 1 then
                      begin
                         clrscr;
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

                         write(gim,g);

                      end
                   else
                      begin  {terminar}
                         writeln('Ingrese un nuevo valor para el valor de la cuota');
                         writeln('Ingrese un nuevo valor para el valor del nutricionista');
                         writeln('Ingrese un nuevo valor para el valor del personal trainer');
                         readkey;
                      end;
                end;

             2: begin
                   clrscr;
                   writeln('Ingrese el codigo de la actividad');
                   repeat
                         readln(a.codigo_actividad);
                   until a.codigo_actividad > 0;
                   writeln('Ingrese la descripcion de la actividad');
                   readln(a.descripcion_actividad);

                   write(act,a);
                end;

             3:  begin
                    clrscr;
                    if filesize(dyh) = 6 then
                    begin
                       writeln('El archivo dias y horarios ya esta completado');
                       readkey;
                    end
                    else
                    begin
                        for i:= 1 to 6 do
                        begin
                            clrscr;
                            writeln('Ingrese el numero del dia (1: Lunes,...,6: Sabado)');
                            readln(dyhreg.dia);
                            writeln('Ingrese la hora del dia ',i);
                            readln(dyhreg.hora);
                            writeln('Ingrese el codigo de la actividad');
                            repeat
                                  readln(dyhreg.codigo_actividad);
                            until dyhreg.codigo_actividad > 0;
                            writeln();

                            write(dyh,dyhreg);
                            writeln('Datos del dia ',i,' guardados correctamente');
                            readkey;
                        end;
                    end;
                 end;
             4:  begin
                    clrscr;
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
          repeat
             readln(op);
          until (op >=1) and (op <= 5);
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
     busqueda:=secuencial_cli(dni);
     if busqueda > -1 then                                {Si la busqueda devuelve mas de -1, quiere decir que se encontro el cliente}
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
               readln(deuda);
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
     if busqueda = -1 then                                                                    {Si la busqueda devuelve -1, quiere decir que el cliente no existe}
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
     if (filesize(rxc)>0) and (filesize(cli)>0) then
     begin
     clrscr;
     pact:=0;
     mes:=0;
     write('Ingrese DNI del cliente: ');
     readln(dni);
     busqueda:=secuencial_cli(dni);
     if filesize(rxc)>0 then
     if (busqueda>=0) and (rxcreg.borrado_logico=false) then
     begin
          seek(rxc,busqueda);
          seek(cli,busqueda);
          write('Mes: ');
          repeat
                readln(rxcreg.mes);
          until (rxcreg.mes>0) and (rxcreg.mes<7);
          write('Año: ');
          repeat
                readln(rxcreg.anio);
          until (rxcreg.anio<3000)and(rxcreg.anio>1);
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
          writeln('Debe actualizar el peso del cliente: ');
          repeat
                readln(pact);
          until pact>0;
          c.pago_en_pesos_y_peso_actual[mes,2]:= pact;
          write(rxc,rxcreg);
          write(cli,c);

     end;
     end;
     if busqueda<0 then
     begin
          writeln('El cliente no existe, debe crearlo primero');
          readkey;
     end;

end;

{============================================================================= LISTADO ============================================================================}

function acti(e:integer):string;
begin
    if filesize(act) = 0 then
        acti:= 'No hay descripcion de actividad'
     else
     begin
          read(act,a);
          seek(act,e);
          acti:= a.descripcion_actividad;
     end;
end;

procedure LISTADO();
var
i:integer;
begin
     if (filesize(gim)>0) and (filesize(dyh)>0) then
     begin
          i:=0;
          read(gim);
          seek(gim,0);
          read(dyh);
          clrscr();
          writeln('Gimnasio: ',g.nombre);
          writeln('Valor de la cuota: ',g.valor_cuota:0:2,'$');
          writeln('Valor del Nutricionista: ',g.valor_nutricionista:0:2,'$');
          writeln('Valor del Personal Trainer: ',g.valor_personal_trainer:0:2,'$');
          writeln();
          for i:=0 to 5 do
          begin
               seek(dyh,i);
               case i of
               0:begin
                      writeln('      Dia: Lunes');
                      writeln('      Hora: ',dyhreg.hora);
                      writeln('      Actividad: ',acti(dyhreg.codigo_actividad));
                      writeln();
                 end;
               1:begin
                      writeln('      Dia: Martes');
                      writeln('      Hora: ',dyhreg.hora);
                      writeln('      Actividad: ',acti(dyhreg.codigo_actividad));
                      writeln();
                 end;
               2:begin
                      writeln('      Dia: Miercoles');
                      writeln('      Hora: ',dyhreg.hora);
                      writeln('      Actividad: ',acti(dyhreg.codigo_actividad));
                      writeln();
                 end;
               3:begin
                      writeln('      Dia: Jueves');
                      writeln('      Hora: ',dyhreg.hora);
                      writeln('      Actividad: ',acti(dyhreg.codigo_actividad));
                      writeln();
                 end;
               4:begin
                      writeln('      Dia: Viernes');
                      writeln('      Hora: ',dyhreg.hora);
                      writeln('      Actividad: ',acti(dyhreg.codigo_actividad));
                      writeln();
                 end;
               5:begin
                      writeln('      Dia: Sabado');
                      writeln('      Hora: ',dyhreg.hora);
                      writeln('      Actividad: ',acti(dyhreg.codigo_actividad));
                      writeln();
                 end;
               end;
          end;
          readkey;
     end;

     if (filesize(gim)=0) or (filesize(dyh)=0) then
     begin
          writeln('No hay registros sobre el gimnasio');
          readkey;
     end;
end;



{===========================================================================RECAUDACION=========================================================================}

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

{===========================================================================REINICIAR=============================================================================}

procedure REINICIAR();
var op: string;
    opc,i,j,k,an,m:integer;
begin
    clrscr;
    writeln('¿Esta seguro de reniciar los archivos? (S/N)');
    repeat
          read(op)
    until (op = 's') or (op = 'n');
    if op = 's' then
    begin
       writeln('¿Que archivo quiere borrar?');
       writeln('1) Clientes');
       writeln('2) Rutinas por Clientes');
       repeat
             read(opc);
       until (opc >= 1) and (opc <= 2);
       if opc = 1 then
       begin
          clrscr;
          if filesize(cli) = 0 then
             writeln('El archivo Clientes esta vacio')
          else
          begin
             seek(cli,0);
             for i:= 0 to filesize(cli) do
             begin
                 read(cli,c);
                 for j:= 1 to 12 do
                    for k:= 1 to 2 do
                       begin
                           c.pago_en_pesos_y_peso_actual[j,k]:= 0;
                           write(cli,c);
                       end;
                 clrscr;
                 writeln('Archivo borrado con exito');
                 readkey;
             end;
          end;
       end
       else
       begin
           clrscr;
           if filesize(rxc) = 0 then
              writeln('El archivo Rutinas por Clientes esta vacio')
           else
           begin
               clrscr;
               writeln('Ingrese el anio del registro que quiere borrar');
               repeat
                    readln(an)
               until (an >= 1) and (an <= 3000);
               writeln('Ingrese el mes del registro que quiere borrar');
               repeat
                     readln(m);
               until (m >= 0) and (m <= 12);

               seek(rxc,0);
               repeat
                    read(rxc,rxcreg);
               until (eof(rxc)) or ((an=rxcreg.anio) and (m=rxcreg.mes));
               if (an = rxcreg.anio) and (m = rxcreg.mes) then
               begin
                  rxcreg.borrado_logico:= true;
                  write(rxc,rxcreg);
                  readkey;
               end
               else
               begin
                   clrscr;
                   writeln('no existe el registro del año ingresado');
                   readkey;
               end;
           end;
       end;
    end;
end;

{=============================================================================MENU==============================================================================}

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
             4: LISTADO();
             5: RECAUDACION();
             6: REINICIAR();
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


{================================================================APERTURA Y ASIGNAMIENTO DE ARCHIVOS====================================================================}


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
