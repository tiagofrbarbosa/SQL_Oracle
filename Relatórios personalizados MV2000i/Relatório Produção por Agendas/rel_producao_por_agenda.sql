          SELECT Prestador,
                 codigo,
                 Servico,
                 TO_DATE(Data_agenda,'DD/MM/YYYY'),
                 inicio,
                 termino,
                 Tipo_Atendimento,
                 Consultas_Ofertadas,
                 Encaixes_Marcados + Consultas_Marcadas total_agendado,
                 Consultas_Atendidas
                 FROM(
              
              SELECT  nm_prestador Prestador,
                      cd_ser_dis  codigo,
                      ds_ser_dis  Servico,
                      dt_agenda Data_agenda,
                      hr_ini inicio,
                      hr_fim termino,
                      ds_tip_mar  Tipo_Atendimento,
                      sum(qt_consultas) Consultas_ofertadas,
                      sum(qt_encaixes_marcados)                                    Encaixes_Marcados,
                      sum(qt_consultas_marcadas) - Sum(qt_encaixes_marcados)       Consultas_Marcadas,
                      sum(atendimento_realizado)                                   Consultas_Atendidas
                      FROM(
              SELECT
                        p.nm_prestador,
                        ser.cd_ser_dis,
                        ser.ds_ser_dis,
                        to_char(ac.dt_agenda,'DD/MM/YYYY') dt_agenda,
                        to_char(ac.hr_inicio,'HH24:MI') hr_ini,
                        to_char(ac.hr_fim,'HH24:MI') hr_fim,
                        mar.ds_tip_mar,
                        (select COUNT(*)TESTE from dbamv.it_agenda_central WHERE cd_agenda_central= ac.cd_agenda_central  AND SN_PUBLICO = 'S' AND SN_ENCAIXE = 'N')qt_consultas,
                        Nvl(ac.qt_encaixes_marcados,0) qt_encaixes_marcados,
                        count(Nvl(ac.qt_marcados,0))   qt_consultas_marcadas,
                        count(cd_atendimento)          atendimento_realizado
                  FROM 
                        dbamv.agenda_central ac,
                        dbamv.it_agenda_central it,
                        dbamv.tip_mar mar,
                        dbamv.ser_dis ser,
                        dbamv.prestador p
                    WHERE 
                        --To_Date(ac.dt_agenda,'DD/MM/YYYY') BETWEEN To_Date(:DT_INICIAL,'DD/MM/YYYY') AND To_Date(:DT_FINAL,'DD/MM/YYYY')  
                          ac.dt_agenda BETWEEN '01-07-2014' AND '31-12-2014'
                    AND p.cd_prestador = ac.cd_prestador
                    AND ac.cd_agenda_central = it.cd_agenda_central
                    AND it.cd_tip_mar        = mar.cd_tip_mar
                    AND ac.cd_multi_empresa  = 1
                    AND it.cd_ser_dis        = ser.cd_ser_dis
                    AND IT.cd_it_agenda_pai IS NULL
                    AND mar.cd_tip_mar = 2
                    AND ser.cd_ser_dis IN(81,37)
                    --AND IT.SN_PUBLICO = 'S'
                    GROUP BY p.nm_prestador,ser.cd_ser_dis,ser.ds_ser_dis, ac.dt_agenda,ac.hr_inicio,ac.hr_fim, mar.ds_tip_mar, qt_atendimento, qt_encaixes_marcados, qt_marcados ,ac.cd_agenda_central
                    )
                    GROUP BY nm_prestador,cd_ser_dis,ds_ser_dis,dt_agenda,hr_ini,hr_fim, ds_tip_mar
                    )
                    --GROUP BY Prestador, Servico, Data_agenda,inicio,termino,Tipo_atendimento,Encaixes_marcados, Consultas_marcadas
                    ORDER BY 1,3,4,TO_DATE(Data_agenda,'DD/MM/YYYY') ASC