@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root view entity for Pre-checks'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZIM_PRE_CHECK_01 as select from /dmo/travel
{
    
     key travel_id as TravelID, 
     begin_date as BeginDate,
     end_date as EndDate,
     @Semantics.amount.currencyCode: 'CurrencyCode'
     booking_fee as BookingFee,
     @Semantics.amount.currencyCode: 'CurrencyCode'
     total_price as TotalPrice,
     currency_code as CurrencyCode,
     description as Description,
     lastchangedat as Lastchangedat
     
}
