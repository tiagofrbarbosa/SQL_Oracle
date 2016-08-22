SELECT P.NM_USUARIO,
       Decode(P.CD_MULTI_EMPRESA,1,'AME',3,'HGG') UNIDADE,
       Count(*) TOTAL
    FROM PACIENTE P
WHERE P.CD_PACIENTE IN(
SELECT CD_PACIENTE
       FROM
       (
SELECT PACIENTE.CD_PACIENTE             CD_PACIENTE
	   ,PACIENTE.DS_CHECAPAC       DS_CHECAPAC
	   ,PACIENTE.NM_PACIENTE        NM_PACIENTE
	   ,To_CHAR(PACIENTE.DT_NASCIMENTO,'DD/MM/YYYY')  DT_NASCIMENTO
	   ,PACIENTE.NM_MAE                 NM_MAE
	   ,PACIENTE.NM_USUARIO        NM_USUARIO
     ,SAME.CD_CAIXA CD_CAIXA
     ,SAME.NR_MATRICULA_SAME PRONT_PAC
     ,Decode(SAME.CD_CAD_SAME,1,'GERAL',2,'TERCEIRO',3,'HGG',5,'INTERFILE',null) CAD_UNID

FROM DBAMV.PACIENTE PACIENTE,
     DBAMV.SAME_CAIXARH SAME
WHERE EXISTS (SELECT 'X'
                                FROM   dbamv.paciente paci
                             WHERE   PACIENTE.CD_PACIENTE          <> PACI.CD_PACIENTE
                                 AND   Paciente.Nm_Paciente          = Paci.Nm_Paciente
                                 AND   (paciente.ds_checaPac         = paci.ds_checaPac
                                   OR    paciente.ds_checaPac         is null
                                   OR    paci.ds_checaPac             IS null)

                                 AND   (TRUNC(Paciente.Dt_Nascimento) = Trunc(Paci.Dt_Nascimento)
                                   OR  Paciente.Dt_Nascimento        IS NULL
                                   OR  Paci.Dt_Nascimento            IS null)

                                 AND  (Paciente.NM_MAE              = Paci.NM_MAE
                                   OR  Paci.NM_MAE                   IS NULL
                                  OR  Paciente.NM_MAE               IS null)


                )
                AND PACIENTE.CD_PACIENTE = SAME.CD_PACIENTE(+)
                  --AND PACIENTE.NM_PACIENTE >= UPPER(:var || '%') AND PACIENTE.NM_PACIENTE <= UPPER(:var2 || '%')
 ORDER BY nm_paciente, DS_CHECAPAC
 )
 )
 GROUP BY P.NM_USUARIO, P.CD_MULTI_EMPRESA
 ORDER BY P.NM_USUARIO