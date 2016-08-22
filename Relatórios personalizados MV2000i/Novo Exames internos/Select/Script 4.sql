SELECT exame,
       consultas_ofertadas,
       encaixes_marcados,
       consultas_marcadas,
       encaixes_marcados + consultas_marcadas total_agendado,
       consultas_atendidas,
       (encaixes_marcados + consultas_marcadas - consultas_atendidas) nao_atendido,
       NAO_AGENDADO
      FROM(
SELECT ds_item_agendamento exame,
       Sum(qt_consultas)                                       Consultas_Ofertadas,
       Sum(qt_encaixes_marcados)                               Encaixes_Marcados,
       Sum(qt_consultas_marcadas) - Sum(qt_encaixes_marcados)  Consultas_Marcadas,
       Sum(atendimento_realizado)                              Consultas_Atendidas,
       Sum(qt_consultas) - (Sum(qt_consultas_marcadas) - Sum(qt_encaixes_marcados))          NAO_AGENDADO
       FROM(
SELECT
    exa.ds_item_agendamento,
    (SELECT Count(*)TESTE FROM dbamv.it_agenda_central WHERE cd_agenda_central = ac.cd_agenda_central AND SN_PUBLICO = 'S' AND SN_ENCAIXE = 'N' AND (CD_USUARIO != 'ACESSOPEP' OR CD_USUARIO IS NULL)) qt_consultas,
    Nvl(ac.qt_encaixes_marcados,0)  qt_encaixes_marcados,
    Count(Nvl(ac.qt_marcados,0))    qt_consultas_marcadas,
    Count(cd_atendimento)           atendimento_realizado,
    ac.cd_agenda_central            COD_AGENDA
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

)
GROUP BY ds_item_agendamento
)
ORDER BY 1;