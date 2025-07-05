import { LightningElement, api } from 'lwc';
import updateStatus from '@salesforce/apex/RecordStatusUpdater.updateStatus';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class UpdateStatusQuickAction extends LightningElement {
    @api recordId;
    success = false;
    error;

    handleClick() {
        updateStatus({ recordId: this.recordId })
            .then(() => {
                getRecordNotifyChange([{ recordId: this.recordId }]);
    
                this.dispatchEvent(new CloseActionScreenEvent());
    
                setTimeout(() => {
                    this.dispatchEvent(new ShowToastEvent({
                        title: 'Success',
                        message: 'The status has been updated.',
                        variant: 'success'
                    }));
                }, 100); 
            })
            .catch((err) => {
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error',
                    message: err.body?.message || 'Unexpected error occurred.',
                    variant: 'error'
                }));
            });
    }
    
    
}
