import { LightningElement, wire, api, track } from 'lwc';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';
import { NavigationMixin } from "lightning/navigation";
//import getRecordId from '@salesforce/apex/TaskPopUp.getRecordId';
import createTask from '@salesforce/apex/TaskPopUp.createTask';
export default class FirstComponent extends NavigationMixin(LightningElement) {

   @api recordId;
   @track isShowModal;
   @track dateValue;

   @track isShowModal = false;
   
 
   @api channelName = '/event/TaskEvent__e';
    subscription = {};
    isShowModal = false;
    connectedCallback() {
        this.subscribeToPlatformEvent();
    }
    subscribeToPlatformEvent() {
        // Callback invoked whenever a new event message is received
        const self = this;
        const messageCallback = function (response) {
            self.isShowModal = true;
            
        };
        // Subscribe to the platform event
        subscribe(this.channelName, -1, messageCallback).then(response => {
            console.log('Subscribed to platform event111 ', JSON.stringify(response));
            this.subscription = response;
            console.log('Subscription', this.subscription);
        }).catch(error => {
            console.error('Error subscribing to platform ', JSON.stringify(error));
        });
        // Error handler:
        onError(error => {
            console.error('Received error1111 ', JSON.stringify(error));
        });
    }
    // Unsubscribe when the component is disconnected
    disconnectedCallback() {
        unsubscribe(this.subscription, response => {
            console.log('Unsubscribe Response: ', JSON.stringify(response));
        });
    }

    handleDateChange(event){
        this.dateValue = event.target.value;

        console.log('date: ' + this.dateValue);
        console.log('date: ' + this.recordId);

    } 

    hideModalBox() {  
        
        console.log('hd',  this.dateValue);
        if(this.dateValue != undefined ){
            createTask({getDate: this.dateValue, getId: this.recordId });
            this.isShowModal = false;
  
        }
        else{
            this.isShowModal = false;
        }
    }

}