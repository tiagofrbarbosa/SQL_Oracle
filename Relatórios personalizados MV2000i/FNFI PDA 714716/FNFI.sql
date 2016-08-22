SELECT  'Empresa ' || e.cd_multi_empresa || ' - ' || e.ds_multi_empresa Empresa
       ,e.cd_multi_empresa  cd_multi_empresa
       ,V1.CD_BANCO    CD_BANCO
       ,e.cd_multi_empresa || ' - ' || e.ds_multi_empresa Empresa_o
       ,V1.DS_BANCO   DS_BANCO
       ,V1.CD_CON_COR CD_CON_COR
       ,V1.DS_CON_COR DS_CON_COR
       ,V1.CD_AGENCIA CD_AGENCIA
       ,V1.DS_AGENCIA DS_AGENCIA
       ,V1.NR_CONTA NR_CONTA
       ,V1.VL_SLD_ATUAL_CONTA VL_SLD_ATUAL_CONTA
       ,V1.VL_CHQ_DEP_NAO_COMP VL_CHQ_DEP_NAO_COMP
       ,V1.CD_CHQ_DEP_NAO_COMP CD_CHQ_DEP_NAO_COMP
       ,V1.VL_CHQ_EMI_NAO_COMP VL_CHQ_EMI_NAO_COMP
       ,V1.CD_CHQ_EMI_NAO_COMP CD_CHQ_EMI_NAO_COMP
       ,V1.SN_CONTA_ESPECIAL SN_CONTA_ESPECIAL
       ,V1.VL_LIMITE_CHEQUE_ESPECIAL VL_LIMITE_CHEQUE_ESPECIAL

       ,decode(v2.dt_estorno,null,DECODE(V2.CD_CHEQUE, NULL, V2.DT_MOVIMENTACAO
          ,decode('C','C',decode(v2.dt_compensacao,null,Decode(1723, 967, v2.dt_compensacao, v2.dt_emissao), Decode(1723, 374, v2.dt_compensacao, v2.dt_movimentacao)),v2.dt_emissao)),v2.dt_estorno) DT_MOVIMENTACAO--PDA 540232 - Edipo Silva

     -- ,To_Date(DECODE(V2.CD_CHEQUE, null, To_Char(v2.dt_movimentacao,'dd/mm/yyyy'),to_char(v2.dt_compensacao,'dd/mm/yyyy')),'dd/mm/yyyy') dt_compensacao

      ,V2.NR_DOCUMENTO_IDENTIFICACAO NR_DOCUMENTO_IDENTIFICACAO
      ,V2.CD_MOV_CONCOR CD_MOV_CONCOR
      ,V2.DS_MOVIMENTACAO DS_MOVIMENTACAO
      ,Decode( 'L', 'A', V2.VL_MOVIMENTACAO, V2.VL_MOVIMENTACAO - Abs(Nvl(Tar.Vl_Movimentacao,0)) )      VL_MOVIMENTACAO
      ,V2.TP_OPERACAO_SALDO_CONTA TP_OPERACAO_SALDO_CONTA
      ,V2.Cd_Mov_Deposito_Agrup
FROM  DBAMV.V_BCO_CONTA   V1,
      dbamv.multi_empresas e,
      DBAMV.V_MOV_CONCOR  V2,
      (select  count(*) total,
               count(decode(M.Sn_Conciliado,'S','S',null)) sim ,
               m.cd_mov_deposito_agrup
         from  dbamv.mov_concor M
        where  m.cd_mov_deposito_agrup Is Not Null
     group by  M.cd_mov_deposito_agrup)  Tb_Conciliacao,
               ( Select Cd_Mov_Pai,
                        Nvl(Sum(Vl_Movimentacao),0) Vl_Movimentacao
                   From Dbamv.V_Mov_Concor M
                  Where 'L'  = 'L'
                    And M.Cd_Estrutural = '1.6.1.1.10.3'
               Group By Cd_Mov_Pai ) Tar
WHERE V1.CD_CON_COR            = V2.CD_CON_COR
  AND V1.cd_multi_empresa      = e.cd_multi_empresa
  AND V2.Cd_Mov_Deposito_Agrup = Tb_Conciliacao.Cd_Mov_Deposito_Agrup(+)
  AND V1.CD_CON_COR       = V2.CD_CON_COR
  AND NVL(V2.VL_MOVIMENTACAO,0) <> 0
  And V2.Cd_Mov_ConCor = Tar.Cd_Mov_Pai(+)

AND V1.CD_BANCO = 1
AND V1.CD_CON_COR = 50
AND e.cd_multi_empresa = 1


AND   decode(v2.dt_estorno,null,DECODE(V2.CD_CHEQUE, NULL, V2.DT_MOVIMENTACAO,
   decode('C','C',decode(v2.dt_compensacao,null,Decode(1723, 967, v2.dt_compensacao, v2.dt_emissao), Decode(1723, 374, v2.dt_compensacao, v2.dt_movimentacao)),v2.dt_emissao)),v2.dt_estorno) >=
   TO_DATE( '16/09/2014', 'DD/MM/YYYY' )

AND decode(v2.dt_estorno,null,DECODE(V2.CD_CHEQUE, NULL, V2.DT_MOVIMENTACAO,
   decode('C','C',decode(v2.dt_compensacao,null,Decode(1723, 967, v2.dt_compensacao, v2.dt_emissao), Decode(1723, 374, v2.dt_compensacao, v2.dt_movimentacao)),v2.dt_emissao)),v2.dt_estorno) <=
   TO_DATE( '30/09/2014', 'DD/MM/YYYY' )

AND ( 'N' = 'N' OR  ( 'N' = 'S' And ( V2.CD_MOV_DEPOSITO_AGRUP Is Null  OR  ( V2.CD_MOV_DEPOSITO_AGRUP Is Not Null  And Tb_Conciliacao.Total <> Tb_Conciliacao.Sim  and Tb_Conciliacao.Sim <> 0  ) ) ) )
And ( ( 'L' = 'L' And V2.CD_ESTRUTURAL <> '1.6.1.1.10.3' ) Or ( 'L'  =   'A')  )

UNION

SELECT 'Empresa ' || e.cd_multi_empresa || ' - ' || e.ds_multi_empresa Empresa
       ,e.cd_multi_empresa  cd_multi_empresa
       ,V1.CD_BANCO    CD_BANCO
       ,e.cd_multi_empresa || ' - ' || e.ds_multi_empresa Empresa_o
       ,V1.DS_BANCO   DS_BANCO
       ,V1.CD_CON_COR CD_CON_COR
       ,V1.DS_CON_COR DS_CON_COR
       ,V1.CD_AGENCIA CD_AGENCIA
       ,V1.DS_AGENCIA DS_AGENCIA
       ,V1.NR_CONTA NR_CONTA
       ,V1.VL_SLD_ATUAL_CONTA VL_SLD_ATUAL_CONTA
       ,V1.VL_CHQ_DEP_NAO_COMP VL_CHQ_DEP_NAO_COMP
       ,V1.CD_CHQ_DEP_NAO_COMP CD_CHQ_DEP_NAO_COMP
       ,V1.VL_CHQ_EMI_NAO_COMP VL_CHQ_EMI_NAO_COMP
       ,V1.CD_CHQ_EMI_NAO_COMP CD_CHQ_EMI_NAO_COMP
       ,V1.SN_CONTA_ESPECIAL SN_CONTA_ESPECIAL
       ,V1.VL_LIMITE_CHEQUE_ESPECIAL VL_LIMITE_CHEQUE_ESPECIAL

       ,decode(v2.dt_estorno,null,DECODE(V2.CD_CHEQUE, NULL, V2.DT_MOVIMENTACAO,
        decode('C','C',decode(v2.dt_compensacao,null,
        Decode(1723, 967, v2.dt_compensacao, v2.dt_emissao), Decode(1723, 374, v2.dt_compensacao, v2.dt_movimentacao)),v2.dt_emissao)),v2.dt_estorno) --PDA 540232 - Edipo Silva

     -- ,To_Date(DECODE(V2.CD_CHEQUE, null, To_Char(v2.dt_movimentacao,'dd/mm/yyyy'),to_char(v2.dt_compensacao,'dd/mm/yyyy')),'dd/mm/yyyy') dt_compensacao

       ,'AG-' || To_Char(V2.Cd_Mov_Deposito_Agrup) NR_DOCUMENTO_IDENTIFICACAO
       ,0 CD_MOV_CONCOR
       ,decode(V2.TP_OPERACAO_SALDO_CONTA,'+', Decode(v2.CD_MOV_CAIXA, NULL,'CRED. AGRUP. MVSAUDE','DEP. AGRUP. CAIXA'), '-' ,
               Decode(v2.cd_bordero, null,  'AGRUPADO', 'PGTO BORD. '|| To_Char(v2.cd_bordero)))  DS_MOVIMENTACAO -- pda 368826 - Frank Melo
       ,Sum(Decode( 'L', 'A', V2.VL_MOVIMENTACAO, V2.VL_MOVIMENTACAO - Abs(Nvl(Tar.Vl_Movimentacao,0)) )) VL_MOVIMENTACAO
       ,V2.TP_OPERACAO_SALDO_CONTA TP_OPERACAO_SALDO_CONTA
       ,V2.Cd_Mov_Deposito_Agrup
FROM   DBAMV.V_BCO_CONTA   V1,
       dbamv.multi_empresas e,
       DBAMV.V_MOV_CONCOR  V2,
       (select  count(*) total,
                count(decode(M.Sn_Conciliado,'S','S',null)) sim ,
                m.cd_mov_deposito_agrup
          from  dbamv.mov_concor M
         where  m.cd_mov_deposito_agrup Is Not Null
      group by  M.cd_mov_deposito_agrup)  Tb_Conciliacao,
                ( Select Cd_Mov_Pai,
                         Nvl(Sum(Vl_Movimentacao),0) Vl_Movimentacao
                    From Dbamv.V_Mov_Concor M
                   Where 'L'   = 'L'
                     And M.Cd_Estrutural = '1.6.1.1.10.3'
                Group By Cd_Mov_Pai ) Tar

WHERE  V1.CD_CON_COR            = V2.CD_CON_COR
  AND  V1.cd_multi_empresa      = e.cd_multi_empresa
  AND  V2.Cd_Mov_Deposito_Agrup = Tb_Conciliacao.Cd_Mov_Deposito_Agrup  (+)
  And  'N' = 'S'
  AND  V1.CD_CON_COR       = V2.CD_CON_COR
  AND  NVL(V2.VL_MOVIMENTACAO,0) <> 0
  And  ( V2.CD_MOV_DEPOSITO_AGRUP Is Not Null  And  Tb_Conciliacao.Total = Tb_Conciliacao.Sim  or Tb_Conciliacao.Sim = 0  )
  And  V2.Cd_Mov_ConCor = Tar.Cd_Mov_Pai(+)
  And    ( ('L' = 'L' And V2.CD_ESTRUTURAL <> '1.6.1.1.10.3') Or ( 'L' = 'A')  )



AND V1.CD_BANCO = 1
AND V1.CD_CON_COR = 50
AND e.cd_multi_empresa = 1



AND   decode(v2.dt_estorno,null,DECODE(V2.CD_CHEQUE, NULL, V2.DT_MOVIMENTACAO,
   decode('C','C',decode(v2.dt_compensacao,null,Decode(1723, 967, v2.dt_compensacao, v2.dt_emissao), Decode(1723, 374, v2.dt_compensacao, v2.dt_movimentacao)),v2.dt_emissao)),v2.dt_estorno)
       >= TO_DATE( '16/09/2014', 'DD/MM/YYYY' )

AND   decode(v2.dt_estorno,null,DECODE(V2.CD_CHEQUE, NULL, V2.DT_MOVIMENTACAO,
   decode('C','C',decode(v2.dt_compensacao,null,Decode(1723, 967, v2.dt_compensacao, v2.dt_emissao), Decode(1723, 374, v2.dt_compensacao, v2.dt_movimentacao)),v2.dt_emissao)),v2.dt_estorno)
       <= TO_DATE( '30/09/2014' , 'DD/MM/YYYY' )

Group by 'Empresa ' || e.cd_multi_empresa || ' - ' || e.ds_multi_empresa
         ,e.cd_multi_empresa , e.cd_multi_empresa || ' - ' || e.ds_multi_empresa , V2.Cd_Mov_Deposito_Agrup
         ,decode(V2.TP_OPERACAO_SALDO_CONTA, '+', Decode(v2.CD_MOV_CAIXA, NULL,'CRED. AGRUP. MVSAUDE','DEP. AGRUP. CAIXA'), '-' ,
               Decode(v2.cd_bordero, null,  'AGRUPADO', 'PGTO BORD. '|| To_Char(v2.cd_bordero)))
         ,V2.TP_OPERACAO_SALDO_CONTA,
         'AG-' || To_Char(V2.Cd_Mov_Deposito_Agrup) ,V1.CD_BANCO ,V1.DS_BANCO ,V1.CD_CON_COR ,V1.DS_CON_COR ,V1.CD_AGENCIA ,V1.DS_AGENCIA
         ,V1.NR_CONTA,V1.VL_SLD_ATUAL_CONTA,V1.VL_CHQ_DEP_NAO_COMP,V1.CD_CHQ_DEP_NAO_COMP
         ,V1.VL_CHQ_EMI_NAO_COMP,V1.CD_CHQ_EMI_NAO_COMP,V1.SN_CONTA_ESPECIAL
         ,V1.VL_LIMITE_CHEQUE_ESPECIAL
         ,decode(v2.dt_estorno,null,DECODE(V2.CD_CHEQUE, NULL, V2.DT_MOVIMENTACAO,decode('C','C',decode(v2.dt_compensacao,null, Decode(1723, 967, v2.dt_compensacao, v2.dt_emissao), Decode(1723, 374, v2.dt_compensacao, v2.dt_movimentacao)),v2.dt_emissao)),v2.dt_estorno)

     -- ,To_Date(DECODE(V2.CD_CHEQUE, null, To_Char(v2.dt_movimentacao,'dd/mm/yyyy'),to_char(v2.dt_compensacao,'dd/mm/yyyy')),'dd/mm/yyyy')
ORDER BY
        DS_CON_COR
       ,DS_AGENCIA
      -- ,dt_compensacao
       ,NR_DOCUMENTO_IDENTIFICACAO
