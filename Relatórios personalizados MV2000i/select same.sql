SELECT
  ac.cd_agenda_central,
  ac.dt_agenda,
  TO_CHAR(ac.hr_inicio,'HH24:MI') hr_inicio,
  TO_CHAR(ac.hr_fim,'HH24:MI') hr_fim,
  ac.qt_atendimento,
  ac.qt_marcados,
  ac.qt_encaixes_marcados,
  ac.qt_tempo_medio,
  ac.cd_prestador,
  prest.nm_prestador,
  TO_CHAR(itage.hr_agenda,'HH24:MI') hr_agenda,
  itage.cd_paciente,
  itage.nm_paciente,
  itage.nr_fone,
  mar.ds_tip_mar,
  serv.ds_ser_dis,
  same.nr_matricula_same,
  sc.cd_caixa,
  sc.cd_cad_same
FROM
  dbamv.agenda_central ac,
  dbamv.prestador prest,
  dbamv.it_agenda_central itage,
  dbamv.ser_dis serv,
  dbamv.tip_mar mar,
  dbamv.same,
  dbamv.same_caixarh sc
WHERE ac.cd_agenda_central   = itage.cd_agenda_central(+)
  AND itage.cd_paciente      = sc.cd_paciente(+)
  AND ac.cd_prestador        = prest.cd_prestador(+)
  AND itage.cd_ser_dis       = serv.cd_ser_dis   (+)
  AND itage.cd_tip_mar       = mar.cd_tip_mar    (+)
  AND itage.cd_paciente      = same.cd_paciente  (+)
  --AND same.cd_cad_same       = sc.cd_cad_same
  AND sc.cd_cad_same(+)      = 1
  AND same.cd_cad_same       = 1
  AND ac.dt_agenda BETWEEN '23-JAN-2014' AND '23-JAN-2014'
  AND prest.CD_prestador     = 34
  AND mar.CD_tip_mar         = 2
  --AND itage.cd_paciente      = 490033
ORDER BY itage.hr_agenda ASC




