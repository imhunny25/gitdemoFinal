import { LightningElement,api } from 'lwc';
import facebook from '@salesforce/resourceUrl/facebook';
import twitter from '@salesforce/resourceUrl/twitter';
import youtube from '@salesforce/resourceUrl/youtube';
import noHeader from '@salesforce/resourceUrl/noHeader';
import { loadStyle } from "lightning/platformResourceLoader";
import avtar from '@salesforce/resourceUrl/avtar';
import img from '@salesforce/resourceUrl/img';
import fetchExtamName from '@salesforce/apex/AllExamNameFetch.fetchExtamName';

export default class ExamLogin extends LightningElement {
    facebookIcon = `${facebook}#facebook`;
    twitterIcon = `${twitter}#twitter`;
    youtubeIcon = `${youtube}#youtube`;
    isLogin = true;
    avtarurl = avtar;
    imgUrl = img;
    isExam = false;
    isQuestion = false;
    @api examId='';
    examName = [];
    // chevronright = `${chevronrighticon}#chevronicon`;
    connectedCallback() {
        loadStyle(this, noHeader)
            .then(result => { });
        
        fetchExtamName().then(result => {
            this.examName = result;
        })
    }

    handleClick()
    {
        this.isLogin = false;
        this.isExam = true;
    }

    isQuestionPageHandler(event)
    {   
        if (this.isQuestion == false)
        {
            this.isQuestion = true;
            if (this.isLogin == false && this.isExam == true)
            {
                this.isExam = false;
                }
        }
        this.examId = event.currentTarget.dataset.id;
        console.log('examId>>>>', this.examId);
        //this.isQuestion = true;
        //this.isExam = false;
    }
}