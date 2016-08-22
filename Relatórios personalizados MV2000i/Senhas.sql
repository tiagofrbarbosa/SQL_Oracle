SELECT --sum(fn_idade(s1.dh_processo,'h',s2.dh_processo))*60"HORAS EM MINUTOS"
       --,sum(fn_idade(s1.dh_processo,'mi',s2.dh_processo))"MINUTOS"
       --,ROUND(avg(fn_idade(s1.dh_processo,'h',s2.dh_processo)))"MEDIA HORAS"
       ROUND(avg(to_char(s2.dh_processo - s1.dh_processo )*1440 ))"MEDIA MINUTOS"
FROM   triagem_atendimento t
       ,sacr_tempo_processo s1 --inicio
       ,sacr_tempo_processo s2 --medico
WHERE  t.cd_triagem_atendimento = s1.cd_triagem_atendimento
AND    t.cd_triagem_atendimento = s2.cd_triagem_atendimento
AND    s1.cd_tipo_tempo_processo = 22
AND    s2.cd_tipo_tempo_processo = 10
AND    S1.cd_atendimento IS NOT NULL
AND    S2.cd_atendimento IS NOT NULL
AND    TO_DATE(S2.DH_PROCESSO,'DD/MM/YYYY') = TO_DATE(S1.dh_processo,'DD/MM/YYYY')
--AND    T.cd_especialid = 36
AND    TO_DATE(T.dh_pre_atendimento, 'DD/MM/YYYY' )  BETWEEN TO_DATE('01-DEZ-2012','DD-MON-YY') AND TO_DATE('31-DEZ-2012','DD-MON-YY')


SELECT --sum(fn_idade(s1.dh_processo,'h',s2.dh_processo))*60"HORAS EM MINUTOS"
       --,sum(fn_idade(s1.dh_processo,'mi',s2.dh_processo))"MINUTOS"
       --,ROUND(avg(fn_idade(s1.dh_processo,'h',s2.dh_processo)))"MEDIA HORAS"
       ROUND(avg(to_char(s2.dh_processo - s1.dh_processo )*1440 ))"MEDIA MINUTOS"
FROM   triagem_atendimento t
       ,sacr_tempo_processo s1 --inicio
       ,sacr_tempo_processo s2 --medico
WHERE  t.cd_triagem_atendimento = s1.cd_triagem_atendimento
AND    t.cd_triagem_atendimento = s2.cd_triagem_atendimento
AND    s1.cd_tipo_tempo_processo = 11
AND    s2.cd_tipo_tempo_processo = 31
AND    T.cd_especialid = 36
AND    TO_DATE(T.dh_pre_atendimento, 'DD/MM/YYYY' )  BETWEEN TO_DATE('21-MAI-2012','DD-MON-YY') AND TO_DATE('25-MAI-2012','DD-MON-YY')


SELECT DS_ESPECIALID "DS_ESPECIALID" ,SUM(CONFIRMADO) "SENHA_ATENDIDA" ,SUM(EXCLUIDO) "SENHA_EXCLUIDA",SUM(CONFIRMADO) + SUM(EXCLUIDO) "SENHA_TOTAL"  FROM (SELECT ESP.DS_ESPECIALID ,COUNT(*) CONFIRMADO ,0 EXCLUIDO FROM DBAMV.TRIAGEM_ATENDIMENTO TRI , DBAMV.SACR_TEMPO_PROCESSO TP, DBAMV.ESPECIALID ESP WHERE  TRI.CD_MULTI_EMPRESA = 1 AND TRI.CD_TRIAGEM_ATENDIMENTO = TP.CD_TRIAGEM_ATENDIMENTO AND TRI.CD_ESPECIALID = ESP.CD_ESPECIALID		 AND TRI.DH_REMOVIDO IS NULL AND TRI.CD_USUARIO_REMOVEU IS NULL AND TP.CD_TIPO_TEMPO_PROCESSO = 20 AND TO_CHAR(TRI.DH_PRE_ATENDIMENTO,'DD/MM/YYYY') = TO_CHAR(SYSDATE, 'DD/MM/YYYY') AND TRI.DS_SENHA LIKE 'P%' GROUP BY DS_ESPECIALID UNION ALL        SELECT    ESP.DS_ESPECIALID ,0 CONFIRMADO ,COUNT(*) EXCLUIDO FROM DBAMV.TRIAGEM_ATENDIMENTO TRI , DBAMV.SACR_TEMPO_PROCESSO TP, DBAMV.ESPECIALID ESP WHERE  TRI.CD_MULTI_EMPRESA = 1 AND TRI.CD_TRIAGEM_ATENDIMENTO = TP.CD_TRIAGEM_ATENDIMENTO AND TRI.CD_ESPECIALID = ESP.CD_ESPECIALID		 AND TRI.DH_REMOVIDO IS NOT NULL AND TRI.CD_USUARIO_REMOVEU IS NOT NULL AND TP.CD_TIPO_TEMPO_PROCESSO = 1 AND TO_CHAR(TRI.DH_PRE_ATENDIMENTO,'DD/MM/YYYY') = TO_CHAR(SYSDATE,'DD/MM/YYYY') AND TRI.DS_SENHA LIKE 'P%' GROUP BY DS_ESPECIALID) GROUP BY DS_ESPECIALID ORDER BY SENHA_TOTAL DESC