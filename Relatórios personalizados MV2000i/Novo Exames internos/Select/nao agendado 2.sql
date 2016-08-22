SELECT
        itage.ds_item_agendamento,
        Count(*)
FROM ATENDIME A,
     AGENDA_CENTRAL AC,
     IT_AGENDA_CENTRAL IT,
     ITEM_AGENDAMENTO ITAGE
WHERE A.CD_ATENDIMENTO NOT IN(
SELECT
    itage.CD_ATENDIMENTO
FROM
    dbamv.item_agendamento exa,
    dbamv.agenda_central ac,
    dbamv.it_agenda_central itage
WHERE
    ac.dt_agenda BETWEEN '08-09-2014' AND '08-09-2014'
AND ac.cd_agenda_central = itage.cd_agenda_central(+)
AND itage.cd_item_agendamento = exa.cd_item_agendamento
AND ac.cd_multi_empresa = 1
AND exa.tp_item IN('I')
AND AC.CD_USUARIO != 'ACESSOPEP'
AND itage.CD_ATENDIMENTO IS NOT NULL
AND itage.SN_PUBLICO = 'S'
)
AND A.DT_ATENDIMENTO BETWEEN '08-09-2014' AND '08-09-2014'
AND A.TP_ATENDIMENTO = 'E'
AND A.CD_MULTI_EMPRESA = 1
AND AC.CD_PRESTADOR = A.CD_PRESTADOR
AND AC.DT_AGENDA BETWEEN '08-09-2014' AND '08-09-2014'
AND AC.CD_USUARIO != 'ACESSOPEP'
AND AC.CD_MULTI_EMPRESA = 1
AND AC.CD_AGENDA_CENTRAL = IT.CD_AGENDA_CENTRAL
AND ITAGE.CD_ITEM_AGENDAMENTO = IT.CD_ITEM_AGENDAMENTO
GROUP BY itage.ds_item_agendamento




SELECT
        Count(*) NAO_AGENDADO
FROM ATENDIME A
WHERE A.CD_ATENDIMENTO NOT IN(
SELECT
    itage.CD_ATENDIMENTO
FROM
    dbamv.item_agendamento exa,
    dbamv.agenda_central ac,
    dbamv.it_agenda_central itage
WHERE
    ac.dt_agenda BETWEEN '08-09-2014' AND '08-09-2014'
AND ac.cd_agenda_central = itage.cd_agenda_central(+)
AND itage.cd_item_agendamento = exa.cd_item_agendamento
AND ac.cd_multi_empresa = 1
AND exa.tp_item IN('I')
AND AC.CD_USUARIO != 'ACESSOPEP'
AND itage.CD_ATENDIMENTO IS NOT NULL
AND itage.SN_PUBLICO = 'S'
)
AND A.DT_ATENDIMENTO BETWEEN '08-09-2014' AND '08-09-2014'
AND A.TP_ATENDIMENTO = 'E'
AND A.CD_MULTI_EMPRESA = 1

SELECT
SELECT DISTINCT(AC.CD_AGENDA_CENTRAL)
       FROM AGENDA_CENTRAL AC
       WHERE AC.CD_PRESTADOR IN(
SELECT
        A.CD_PRESTADOR
FROM ATENDIME A
WHERE A.CD_ATENDIMENTO NOT IN(
SELECT
    itage.CD_ATENDIMENTO
FROM
    dbamv.item_agendamento exa,
    dbamv.agenda_central ac,
    dbamv.it_agenda_central itage
WHERE
    ac.dt_agenda BETWEEN '05-09-2014' AND '05-09-2014'
AND ac.cd_agenda_central = itage.cd_agenda_central(+)
AND itage.cd_item_agendamento = exa.cd_item_agendamento
AND ac.cd_multi_empresa = 1
AND exa.tp_item IN('I')
AND AC.CD_USUARIO != 'ACESSOPEP'
AND itage.CD_ATENDIMENTO IS NOT NULL
AND itage.SN_PUBLICO = 'S'
)
AND A.DT_ATENDIMENTO BETWEEN '05-09-2014' AND '05-09-2014'
AND A.TP_ATENDIMENTO = 'E'
AND A.CD_MULTI_EMPRESA = 1
GROUP BY A.CD_PRESTADOR
)
AND ac.dt_agenda BETWEEN '05-09-2014' AND '05-09-2014'
AND ac.cd_multi_empresa = 1
AND AC.CD_USUARIO != 'ACESSOPEP'

SELECT * FROM PED_RX