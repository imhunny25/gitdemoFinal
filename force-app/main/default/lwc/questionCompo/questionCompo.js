import { LightningElement,api, track } from 'lwc';
import fetchQuestion from '@salesforce/apex/AllExamNameFetch.fetchQuestion'
//import fetchAnswer from '@salesforce/apex/AllExamNameFetch.fetchAnswer'

export default class QuestionCompo extends LightningElement {
    question = [];
    answer = [];
    questionNext = {};
    button = [];
    que=1;
    @api examid;
    currentQuestion;
    currentAnswer;
    totalQuestion = 0;
    isShowPrev = false;
    isShowNext = true;
    num = 1;
    btnInder;
    rightAnswer = [];
    currentRightAns;
    totalRightAns = 0;
    totalWrongAns = 0;
    failPass;
    percentage = 0;
    timestart = false;
    connectedCallback() {
        fetchQuestion({examId: this.examid}).then(result => {
            this.question = result;
            this.totalQuestion = result.length;
            if(this.num == 1 && this.num !=2){
                for (var i = 1; i <= this.totalQuestion; i++)
                 {
                    this.button.push(i);
                    this.num = this.num + 1;
                }
            }
            console.log('this.totalQuestion', this.totalQuestion);
            // console.log('this.que in conntercall back', this.que);
            console.log('this.que>>>>', this.que);
            this.currentQuestion = this.question[0].Question__c;
            this.currentRightAns = this.question[0].Correct_Answer__c;
            this.currentAnswer = this.question[0].Answers__r;
            console.log('this.currentRightAns',JSON.stringify( this.currentRightAns));
            //console.log('result>>>', result[5].Question__c);
            //console.log('this.question>>>>>', JSON.stringify(this.question));
            // console.log('this.currentQuestion>>>>>', JSON.stringify(this.currentQuestion));
            // console.log('this.currentAnswer>>>>>', JSON.stringify(this.currentAnswer));
        })
            .catch(error => {
            
            });
       
    }
    previousHandler(event)
    {
        if (this.que == 1)
        {
            this.isShowPrev = false;
        }
        else if (this.que >= 1) {
            console.log('this.que>>>>>> before', this.que);
            this.que = parseInt(this.que)- 1;
            console.log('this.que', this.que);
            this.isShowPrev = true;
            this.currentQuestion = this.question[this.que-1].Question__c;
            this.currentAnswer = this.question[this.que - 1].Answers__r;
            this.currentRightAns = this.question[this.que - 1].Correct_Answer__c;
            this.isShowNext = true;
        }
    }
    nextHandler(event) {
        console.log('this.que before', this.que);
        this.que =parseInt(this.que)+1;
        console.log('this.que', this.que);
        this.isShowPrev = true;
        this.currentQuestion = this.question[this.que-1].Question__c;
        this.currentAnswer = this.question[this.que - 1].Answers__r;
        this.currentRightAns = this.question[this.que - 1].Correct_Answer__c;
        if (this.totalQuestion == this.que)
        {
            this.isShowNext = false;
            this.isShowPrev = true;
        }
    }

    questionHandler(event)
    {
        this.btnInder = event.currentTarget.dataset.id;
        console.log('btnIndex>>>>', this.btnInder);
        this.que = this.btnInder;
        this.currentQuestion = this.question[this.que-1].Question__c;
        this.currentAnswer = this.question[this.que - 1].Answers__r;
        this.currentRightAns = this.question[this.que - 1].Correct_Answer__c;
        if (this.btnInder >= 1 && this.btnInder < this.totalQuestion)
        {
            this.isShowNext = true;
        } else {
            this.isShowNext = false;
        }
        if (this.btnInder > 1 && this.btnInder < this.totalQuestion)
        {
            this.isShowPrev = true;
            }
    }

    @track showStartBtn = true;
    @track timeVal = '0:0:0:0';
    timeIntervalInstance;
    totalMilliseconds = 0;

    start(event) {
        this.showStartBtn = false;
        var parentThis = this;
        this.timestart = true;

        // Run timer code in every 100 milliseconds
        this.timeIntervalInstance = setInterval(function() {

            // Time calculations for hours, minutes, seconds and milliseconds
            var hours = Math.floor((parentThis.totalMilliseconds % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor((parentThis.totalMilliseconds % (1000 * 60 * 60)) / (1000 * 60));
            var seconds = Math.floor((parentThis.totalMilliseconds % (1000 * 60)) / 1000);
            var milliseconds = Math.floor((parentThis.totalMilliseconds % (1000)));
            
            // Output the result in the timeVal variable
            parentThis.timeVal = hours + ":" + minutes + ":" + seconds + ":" + milliseconds;   
            
            parentThis.totalMilliseconds += 100;
        }, 100);
    }

    // stop(event) {
    //     this.showStartBtn = true;
    //     clearInterval(this.timeIntervalInstance);
    // }

    // reset(event) {
    //     this.showStartBtn = true;
    //     this.timeVal = '0:0:0:0';
    //     this.totalMilliseconds = 0;
    //     clearInterval(this.timeIntervalInstance);
    // }

   
    closeModal() {
        this.isModalOpen = false;
    }
    submitDetails() {
        this.isModalOpen = false;
    }

    answerHandler(event) {
        this.start();
        if (this.timestart == true) {
            this.value = event.target.value;        
            if (this.value == this.currentRightAns)
            {
                this.rightAnswer.push(this.value);
            }
           
        } 

        
    }
    @track isModalOpen = false;
    openModal() {
        clearInterval(this.timeIntervalInstance);
        this.timestart = false;
        this.isModalOpen = true;
        this.totalRightAns = this.rightAnswer.length;
        this.totalWrongAns = this.totalQuestion - this.totalRightAns;
        this.percentage = (this.totalRightAns / this.totalQuestion) * 100;

        if (this.percentage <= 40.00)
        {
            this.failPass = 'Fail';
        } else {
            this.failPass = 'Pass';
            }

    }
}
// SELECT ID, Question__c, Correct_Answer__c,(SELECT ID, Answer__c FROM Answers__r) FROM Questions__C Where Id = 'a0Y5g000004JzZQEA0'