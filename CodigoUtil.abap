						CODIGO UTIL
**********************************************************************
**********************************************************************

Saltar transacciones sin autorización
FM: rs_hdsys_call_tc_variant

**********************************************************************
**********************************************************************

Llamar método desde AMDP
NEW zcl_amdp_bc_params( )->get_constant(
      EXPORTING im_progname = 'ZFI001'			"Id desarrollo
                im_constant = gc_constant		"Nombre constante
                im_modulo   = 'FI'			"Módulo
      IMPORTING et_constant = DATA(lt_tconstant) ).
	  
NEW zcl_amdp_bc_params( )->get_all_constant(
      EXPORTING im_progname = 'ZFI001'			"Id desarrollo
                im_constant = gc_constant		"Nombre constante
                im_modulo   = 'FI'			"Módulo
      IMPORTING et_constant = DATA(lt_all_tconstant) ).
	  
NEW zcl_amdp_bc_params( )->get_range(
      EXPORTING im_progname = 'ZFI001'			"Id desarrollo
				im_range	= gc_range			"Identificador del rango 
                im_modulo   = 'FI'			"Módulo
      IMPORTING ex_range    = DATA(lt_range) ).
	  
**********************************************************************
**********************************************************************

Convertir parámetro a rango
lr_fkart = value #( ( sign = 'I' option = 'EQ' low = gv_fkart ) ).

**********************************************************************
**********************************************************************

CONSTRUIR WHERE DINÁMICO
DATA(lv_where) = cl_shdb_seltab=>combine_seltabs(
      it_named_seltabs = VALUE #(
        ( name = 'WERK'             dref = REF #( is_prmtrs-werks ) )           "Centro
        ( name = 'HERKUNFT'         dref = REF #( is_prmtrs-herkunft ) )        "
        ( name = 'LAGORTVORG'       dref = REF #( is_prmtrs-lagortvorg ) )      "Almacen
      )
    ).
	
*.Create where clause for LQUA table (SELECT OPTIONS OR RANGES)
  DATA(lv_where_lqua) = cl_shdb_seltab=>combine_seltabs(
    it_named_seltabs = VALUE #(
      ( name = 'LGTYP'    dref = REF #( grr_lgtyp[] ) )
      ( name = 'LGPLA'    dref = REF #( grr_lgpla[] ) )
      ( name = 'LENUM'    dref = REF #( grr_lenum[] ) )
      ( name = 'MATNR'    dref = REF #( grr_matnr[] ) )
      ( name = 'SONUM'    dref = REF #( grr_sonum[] ) )
      ( name = 'IDATU'    dref = REF #( grr_idatu[] ) ) 
      )
    iv_client_field = 'CLIENT' ).

**********************************************************************
**********************************************************************

READ TABLE POR INDEX
	TRY.
      DATA(ls_lotsel) = gt_lotsel[ 1 ].
      CATCH cx_sy_itab_line_not_found INTO DATA(lo_ref).
    ENDTRY.

**********************************************************************
**********************************************************************

CONVERSIÓN RÁPIDA DE FORMATO
DATA(lv_nlenr) = |{ <lfs_ua_lotes>-nlenr ALPHA = OUT }|.

**********************************************************************
**********************************************************************

CAPTURAR MENSAJES DE UN MODULO DE FUNCIÓN
error_message = 99

**********************************************************************
**********************************************************************

ST03N - Ver sesión de trabajo del usuario
SM04 - Ver usuarios activos en el sistema

**********************************************************************
**********************************************************************

REDUCE - Sumatoria de valores en una tabla interna
DATA(cantidad_hijas_2) = REDUCE ltap_nista( INIT val TYPE ltap_nista
                                         FOR wa_hija IN  lti_uah
                                         NEXT val = val + wa_hija-nista ).
										 
**********************************************************************
**********************************************************************										 
Radio Button Dinámico

1. Evento At selection Screen Output
*----------------------------------------------------------------------*
* Eventos: AT SELECTION-SCREEN ON VALUE-REQUEST
*----------------------------------------------------------------------*
	AT SELECTION-SCREEN OUTPUT.
    PERFORM on_value_request_radiobutton.
2. Radio button en include TOP
	SELECTION-SCREEN: BEGIN OF BLOCK bloq_general WITH FRAME TITLE text-001.

    SELECT-OPTIONS:
      so_matnr      FOR gv_matnr            MODIF ID op1,
      so_ersda      FOR gv_ersda            MODIF ID op1.

    PARAMETERS:
      pa_mtart      TYPE mara-mtart         MODIF ID op1.

  SELECTION-SCREEN: END OF BLOCK bloq_general.

  SELECTION-SCREEN: BEGIN OF BLOCK bloq_radio WITH FRAME TITLE text-003.

    PARAMETERS:
      pa_file TYPE string                   MODIF ID op2.

    PARAMETERS:
      radio1    RADIOBUTTON GROUP g1 DEFAULT 'X' USER-COMMAND uc1,
      radio2    RADIOBUTTON GROUP g1.

  SELECTION-SCREEN: END OF BLOCK bloq_radio.
3. Perform on_value_request 
	IF radio1 = abap_true.
    LOOP AT SCREEN.
      IF screen-group1 = 'OP1'.
        screen-active = '1'.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 = 'OP2'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ELSE.
    LOOP AT SCREEN.
      IF screen-group1 = 'OP1'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 = 'OP2'.
        screen-active = '1'.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.

**********************************************************************
**********************************************************************
IMPRIMIR CDS RÁPIDAMENTE
cl_salv_gui_table_ida=>create_for_cds_view( 'Nombre_cds' )->fullscreen( )->display( ).



