public class OpportunityService{
    private static final String DEFAULT_PRODUCT_NAME = 'Standart Product';
    private static final Decimal DEFAULT_PRODUCT_PRICE = 1000;
    private static final Decimal DEFAULT_PRODUCT_QUANTITY = 1;
    public static void applyDiscount(List<Opportunity> opportunities, Decimal discountPercentage){
        if (opportunities == null || opportunities.isEmpty() || discountPercentage == null){
            return;
        }

        Date firstDayOfMonth = Date.today().toStartOfMonth();
        Date lastDayOfMonth = firstDayOfMonth.addMonths(1).addDays(-1);

        for (Opportunity opp : opportunities){
            if (opp.CloseDate != null && opp.CloseDate >= firstDayOfMonth && opp.CloseDate <= lastDayOfMonth){
                if (opp.Amount != null){
                    opp.Amount *= (1 - discountPercentage);
                }
                if (Schema.sObjectType.Opportunity.fields.Discount_Percentage__c.isUpdateable()){
                    opp.Discount_Percentage__c = discountPercentage * 100;
                }
            }
        }
    }

    public static void applyDiscount(List<Opportunity> opportunities){
        applyDiscount(opportunities, 0.1);
    }

    public static void addDefaultProduct(List<Id> opportunityIds){
        if (opportunityIds == null || opportunityIds.isEmpty()){
            return;
        }

        List<Opportunity> opportunities = [SELECT Id, Amount
                                           FROM Opportunity
                                           WHERE Id IN:opportunityIds AND Amount > 100000];

        if (opportunities.isEmpty()){
            return;
        }

        Id productId = findOrCreateDefaultProduct();
        if (productId == null){
            System.debug('Could not find or create a standard product');
            return;
        }

        List<OpportunityLineItem> lineItems = new List<OpportunityLineItem>();
        for (Opportunity opp : opportunities){
            lineItems.add(new OpportunityLineItem(
                OpportunityId = opp.Id, 
                Product2Id = productId, 
                Quantity = DEFAULT_PRODUCT_QUANTITY, 
                UnitPrice = DEFAULT_PRODUCT_PRICE 
            ));
        }

        if (!lineItems.isEmpty()){
            insert lineItems;
        }
    }

    private static Id findOrCreateDefaultProduct(){
        List<Product2> products = [SELECT Id
                                   FROM Product2
                                   WHERE Name = :DEFAULT_PRODUCT_NAME
                                   LIMIT 1];

        if (!products.isEmpty()){
            return products[0].Id;
        }

        Product2 newProduct = new Product2(
            Name = DEFAULT_PRODUCT_NAME, 
            IsActive = true
        );
        insert newProduct;

        Pricebook2 standardPricebook = [SELECT Id
                                        FROM Pricebook2
                                        WHERE IsStandard = true
                                        LIMIT 1];

        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id, 
            Product2Id = newProduct.Id, 
            UnitPrice = DEFAULT_PRODUCT_PRICE, 
            IsActive = true
        );
        insert pbe;

        return newProduct.Id;
    }

}