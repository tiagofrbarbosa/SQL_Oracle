SELECT nm_prestador,
       SERVICO,
       TIPO_ATENDIMENTO,
       CONSULTAS_OFERTADAS,
       TOTAL_AGENDADO,
       CONSULTAS_ATENDIDAS
      FROM(
SELECT nm_prestador 
     ,servico
	   , tipo_atendimento
	   , consultas_ofertadas
	   , Encaixes_Marcados
	   , Consultas_Marcadas
	   , Encaixes_Marcados + Consultas_Marcadas total_agendado
	   , Consultas_Atendidas
	   , (Encaixes_Marcados + Consultas_Marcadas -  Consultas_Atendidas) nao_atendido
	   , NAO_AGENDADO
  FROM (
                SELECT nm_prestador                                                 nm_prestador,
                       ds_ser_dis                                                   Servico, 
                       ds_tip_mar                                                   Tipo_Atendimento,
                       Sum(qt_consultas)                                            Consultas_Ofertadas, 
                       Sum(qt_encaixes_marcados)                         	        Encaixes_Marcados, 
                       Sum(qt_consultas_marcadas) - Sum(qt_encaixes_marcados)       Consultas_Marcadas, 
                       Sum(atendimento_realizado) 	                                Consultas_Atendidas,
                       SUM(NAO_AGENDADO)                                            NAO_AGENDADO
                       
                FROM (
                    SELECT 
                        p.nm_prestador,
                        ser.ds_ser_dis,

                        mar.ds_tip_mar,
                        (select COUNT(*)TESTE from dbamv.it_agenda_central WHERE cd_agenda_central= ac.cd_agenda_central  AND SN_PUBLICO = 'S' AND SN_ENCAIXE = 'N')qt_consultas,
                        --Nvl(ac.qt_atendimento,0)       qt_consultas,

                        Nvl(ac.qt_encaixes_marcados,0) qt_encaixes_marcados,
                        count(Nvl(ac.qt_marcados,0))   qt_consultas_marcadas,
                        count(cd_atendimento)          atendimento_realizado,
                        0                              NAO_AGENDADO,
                        ac.cd_agenda_central           COD_AGENDA 
                    FROM 
                        dbamv.agenda_central ac,
                        dbamv.it_agenda_central it,
                        dbamv.tip_mar mar,
                        dbamv.ser_dis ser,
                        dbamv.prestador p
                    WHERE 
                        --To_Date(ac.dt_agenda,'DD/MM/YYYY') BETWEEN To_Date(:DT_INICIAL,'DD/MM/YYYY') AND To_Date(:DT_FINAL,'DD/MM/YYYY')
                        ac.dt_agenda BETWEEN  '01-07-2014' AND '31-12-2014'
                        AND P.cd_prestador = ac.CD_PRESTADOR
                    AND ac.cd_agenda_central = it.cd_agenda_central
                    AND it.cd_tip_mar        = mar.cd_tip_mar
                    AND ac.cd_multi_empresa  = 1
                    AND it.cd_ser_dis        = ser.cd_ser_dis
                    AND IT.cd_it_agenda_pai IS NULL
                    --AND IT.SN_PUBLICO = 'S'
                    GROUP BY p.nm_prestador,ser.ds_ser_dis, ac.dt_agenda, mar.ds_tip_mar, qt_atendimento, qt_encaixes_marcados, qt_marcados ,ac.cd_agenda_central

UNION ALL

SELECT p.NM_PRESTADOR,SER_DIS.ds_ser_dis SERVICO,TIP_MAR.ds_tip_mar, 0 CONSULTAS_OFERTADAS,0 ENCAIXES_MARCADOS,0 QT_CONSULTAS_MARCADAS,0 CONSULTAS_ATENDIDAS,COUNT(*) NAO_AGENDADO,0 COD_AGENDA   
  FROM prestador p, ATENDIME, TIP_MAR, SER_DIS  
 WHERE CD_ATENDIMENTO NOT IN ( SELECT 
                       IT.CD_ATENDIMENTO
                    FROM 
                        dbamv.agenda_central ac,
                        dbamv.it_agenda_central it,
                        dbamv.tip_mar mar,
                        dbamv.ser_dis ser
                    WHERE 
                        --To_Date(ac.dt_agenda,'DD/MM/YYYY') BETWEEN To_Date(:DT_INICIAL,'DD/MM/YYYY') AND To_Date(:DT_FINAL,'DD/MM/YYYY')
                        ac.dt_agenda BETWEEN  '01-07-2014' AND '31-12-2014'
                        AND P.cd_prestador = ac.cd_prestador
                    AND ac.cd_agenda_central = it.cd_agenda_central(+)
                    AND it.cd_tip_mar        = mar.cd_tip_mar
                    AND ac.cd_multi_empresa  = 1
                    AND it.cd_ser_dis        = ser.cd_ser_dis
                    AND IT.CD_ATENDIMENTO IS NOT NULL
                    AND IT.SN_PUBLICO = 'S'
                    )
                    --AND to_date(ATENDIME.DT_ATENDIMENTO,'DD/MM/YYYY') BETWEEN To_Date(:DT_INICIAL,'DD/MM/YYYY') AND To_Date(:DT_FINAL,'DD/MM/YYYY')
                    AND P.CD_PRESTADOR = ATENDIME.CD_PRESTADOR
                    AND ATENDIME.DT_ATENDIMENTO BETWEEN '01-07-2014' AND '31-12-2014'
                    AND ATENDIME.CD_MULTI_EMPRESA = 1 
                    AND ATENDIME.TP_ATENDIMENTO = 'A'
    AND ATENDIME.cd_ser_dis = SER_DIS.CD_SER_DIS
    AND ATENDIME.cd_tip_mar = TIP_MAR.CD_TIP_MAR
    GROUP BY p.nm_prestador,SER_DIS.ds_ser_dis ,ATENDIME.DT_ATENDIMENTO,TIP_MAR.ds_tip_mar
    
)
GROUP BY nm_prestador,ds_ser_dis, ds_tip_mar
)
order by 1,2 asc
)
WHERE SERVICO IN('HEMATOLOGIA INFANTIL','PNEUMOLOGIA / EXTRAS','PNEUMOLOGIA/TISIOLOGIA')
ORDER BY 1,2