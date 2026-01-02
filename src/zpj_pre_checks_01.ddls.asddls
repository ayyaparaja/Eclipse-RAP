@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Pre checks'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPJ_PRE_CHECKS_01 as projection on ZIM_PRE_CHECK_01
{
    //@UI - for Display into Fiori Page
    @UI.facet: [{ type: #IDENTIFICATION_REFERENCE }]    
    @UI.lineItem: [{ position: 10  }]           //Table Fields
    @UI.identification: [{ position: 10 }]      //table Fields identification
    key TravelID,
    @UI.lineItem: [{ position: 20  }]
    @UI.identification: [{ position: 20 }]
    BeginDate,
    @UI.lineItem: [{ position: 30  }]
    @UI.identification: [{ position: 30 }]
    EndDate,
    @UI.lineItem: [{ position: 40  }]
    @UI.identification: [{ position: 40 }]
    @Semantics.amount.currencyCode: 'CurrencyCode'  //This annotation mandatory for giving price or amount
    BookingFee,
    @UI.lineItem: [{ position: 50  }]
    @UI.identification: [{ position: 50 }]
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    @UI.lineItem: [{ position: 60  }]
    @UI.identification: [{ position: 60 }]
    CurrencyCode,
    @UI.lineItem: [{ position: 70  }]
    @UI.identification: [{ position: 70 }]
    Description,
    @UI.lineItem: [{ position: 80  }]
    @UI.identification: [{ position: 80 }]
    Lastchangedat
}
