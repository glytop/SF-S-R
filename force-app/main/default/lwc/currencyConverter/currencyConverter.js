import { LightningElement, track } from 'lwc';
import convertCurrency from '@salesforce/apex/ExchangeRateController.convert';

export default class CurrencyConverter extends LightningElement {
    @track usd = 0;
    @track byn;
    @track error;
    @track isLoading = false;
    @track targetCurrency = 'BYN';

    currencyOptions = [
        { label: 'INR (Indian Rupee)', value: 'INR' },
        { label: 'EUR (EURO)', value: 'EUR' },
        { label: 'GBP (British Pound)', value: 'GBP' },
        { label: 'JPY (Japanese Yen)', value: 'JPY' },
        { label: 'BYN (Belarusian Ruble)', value: 'BYN' }
    ];

    handleInput(event) {
        this.usd = event.target.value;
    }

    handleCurrencyChange(event) {
        this.targetCurrency = event.detail.value;
    }

    handleConvert() {
        this.byn = null;
        this.error = null;
        this.isLoading = true;

        convertCurrency({ usd: this.usd, target: this.targetCurrency })
            .then(result => {
                this.byn = result.toFixed(2);
            })
            .catch(err => {
                this.error = err.body.message;
            })
            .finally(() => {
                this.isLoading = false;
            });
    }
}
