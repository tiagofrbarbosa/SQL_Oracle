SELECT
        exa.ds_item_agendamento
      FROM
        dbamv.item_agendamento exa,
        dbamv.it_agenda_central itage,
        dbamv.agenda_central ac
    WHERE itage.cd_atendimento NOT IN(
SELECT
    itage.CD_ATENDIMENTO
FROM
    dbamv.item_agendamento exa,
    dbamv.agenda_central ac,
    dbamv.it_agenda_central itage
WHERE
    ac.dt_agenda BETWEEN '01-09-2014' AND '01-09-2014'
AND ac.cd_agenda_central = itage.cd_agenda_central
AND itage.cd_item_agendamento = exa.cd_item_agendamento
AND ac.cd_multi_empresa = 1
AND exa.tp_item IN('I')
AND AC.CD_USUARIO != 'ACESSOPEP'
AND itage.CD_ATENDIMENTO IS NOT NULL
AND itage.SN_PUBLICO = 'S'
)

AND itage.cd_item_agendamento = exa.cd_item_agendamento
AND ac.cd_agenda_central = itage.cd_agenda_central
AND exa.tp_item IN('I')
AND AC.CD_USUARIO != 'ACESSOPEP'
AND itage.cd_it_agenda_pai IS NULL
AND ac.cd_multi_empresa = 1
--GROUP BY exa.ds_item_agendamento






SELECT
    exa.ds_item_agendamento,
    0  qt_consultas,
    0  qt_encaixes_marcados,
    0  qt_consultas_marcadas,
    0  atendimento_realizado,
    Count(*) NAO_AGENDADO,
    0            COD_AGENDA
FROM
    dbamv.item_agendamento exa,
    dbamv.agenda_central ac,
    dbamv.it_agenda_central itage
WHERE
  itage.cd_it_agenda_central NOT IN(
                  SELECT
    itage.cd_it_agenda_central
FROM
    dbamv.item_agendamento exa,
    dbamv.agenda_central ac,
    dbamv.it_agenda_central itage
WHERE
    ac.dt_agenda BETWEEN '01-09-2014' AND '01-09-2014'
AND ac.cd_agenda_central = itage.cd_agenda_central
AND itage.cd_item_agendamento = exa.cd_item_agendamento
AND ac.cd_multi_empresa = 1
AND exa.tp_item IN('I')
AND AC.CD_USUARIO != 'ACESSOPEP'
AND itage.CD_ATENDIMENTO IS NOT NULL
AND itage.SN_PUBLICO = 'S'
        )
    AND ac.dt_agenda BETWEEN '01-09-2014' AND '01-09-2014'
AND ac.cd_agenda_central = itage.cd_agenda_central
AND itage.cd_item_agendamento = exa.cd_item_agendamento
AND ac.cd_multi_empresa = 1
AND exa.tp_item IN('I')
AND AC.CD_USUARIO != 'ACESSOPEP'
AND itage.cd_it_agenda_pai IS NULL
GROUP BY exa.ds_item_agendamento,ac.cd_agenda_central,qt_encaixes_marcados

SELECT * FROM it_agenda_central