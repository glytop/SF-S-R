declare module "@salesforce/apex/ExchangeRateController.convert" {
  export default function convert(param: {usd: any, target: any}): Promise<any>;
}
