SELECT
    exa.ds_item_agendamento,
    0 qt_consultas,
    0 qt_encaixes_marcados,
    0 qt_consultas_marcadas,
    0 atendimento_realizado,
    Count(*) NAO_AGENDADO,
    0 COD_AGENDA
FROM
    dbamv.item_agendamento exa,
    dbamv.agenda_central ac,
    dbamv.it_agenda_central itage
WHERE
    --To_Date(ac.dt_agenda,'DD/MM/YYYY') BETWEEN To_Date(:DT_INICIAL,'DD/MM/YYYY') AND To_Date(:DT_FINAL,'DD/MM/YYYY')
      ac.dt_agenda BETWEEN '05-09-2014' AND '05-09-2014'
AND ac.cd_agenda_central = itage.cd_agenda_central
AND itage.cd_item_agendamento = exa.cd_item_agendamento
AND ac.cd_multi_empresa = 1
AND exa.tp_item IN('I')
AND AC.CD_USUARIO != 'ACESSOPEP'
AND itage.cd_it_agenda_pai IS NULL
GROUP BY exa.ds_item_agendamento,ac.cd_agenda_central,qt_encaixes_marcados

SELECT E.DS_ESPECIALID FROM ATENDIME A,ESPECIALID E
 WHERE A.CD_ATENDIMENTO = 2944951
 AND A.CD_ESPECIALID = E.CD_ESPECIALID

SELECT * FROM atendime WHERE cd_atendimento = 2944951

SELECT * FROM PED_RX WHERE CD_ATENDIMENTO = 2944969
SELECT * FROM SET_EXA WHERE CD_SET_EXA = 25

