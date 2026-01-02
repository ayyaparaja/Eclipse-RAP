CLASS lhc_PreChecks DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_features FOR GLOBAL FEATURES
      IMPORTING REQUEST requested_features FOR PreChecks RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR PreChecks RESULT result.

    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE PreChecks.

ENDCLASS.

CLASS lhc_PreChecks IMPLEMENTATION.

  METHOD get_global_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD precheck_update.
  "all updated values are available in entities from UI
  LOOP AT entities assigning field-symbol(<fs_entity>).
    check <fs_entity>-%control-BeginDate eq '01' or <fs_entity>-%control-EndDate eq '01'.


   "Read entity record and store it on internal table
   read entities of zim_pre_check_01 in local mode
   entity PreChecks
   fields ( BeginDate EndDate ) with value #( ( %key = <fs_entity>-%key ) )
   result data(lt_pre_checks).

   if sy-subrc eq 0.
    assign lt_pre_checks[ 1 ] to field-symbol(<ls_pre_checks>).

    if sy-subrc eq 0.
        "when user user update front end it save those values
        <ls_pre_checks> = VALUE #( BASE <ls_pre_checks>
                                  BeginDate = switch #( <fs_entity>-%control-BeginDate when '01' then <fs_entity>-BeginDate
                                                                                       else <ls_pre_checks>-BeginDate )
                                  EndDate = switch #( <fs_entity>-%control-EndDate when '01' then <fs_entity>-EndDate
                                                                                       else <ls_pre_checks>-EndDate ) ).

       "Validate the Start Date is lesser than the End Date
       if <ls_pre_checks>-BeginDate > <ls_pre_checks>-EndDate.
        "Return an error message to front end
        Append value #( %tky = <fs_entity>-%tky ) to failed-prechecks.

        Append value #( %tky = <fs_entity>-%tky
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Start Date should not be Greater than End Date') ) to reported-prechecks.


        "Validate the Total Price is lesser than the 1000
       if <ls_pre_checks>-TotalPrice < 1000.
        "Return an error message to front end
        Append value #( %key = <fs_entity>-%key
                        %update = if_abap_behv=>mk-on ) to failed-prechecks.

        Append value #( %tky = <fs_entity>-%tky
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Total Price should not less than 1000' )
                        %update = if_abap_behv=>mk-on ) to reported-prechecks.
       endif.
       endif.
    endif.
   endif.
   endloop.
  ENDMETHOD.

ENDCLASS.
