import { LightningElement, track } from 'lwc';

const tasks = [
    {   
        taskid: "ta1",
        name:"Angular",
        category:"wip"
    },  
    {   
        taskid: "ta2",
        name:"React", 
        category:"wip"
    },
    {   
        taskid: "ta5",
        name:"Python",
        category:"wip"
    },  
    {   
        taskid: "ta6",
        name:"Salesforce", 
        category:"wip"
    }, 
    {   
        taskid: "ta3",
        name:"Vue", 
        category:"complete"
    },
    {
        taskid: "ta4",
        name: "Lightning Web Component",
        category: "complete"
    },
    {   
        taskid: "ta7",
        name:"Programming", 
        category:"complete"
    },
    {
        taskid: "ta8",
        name: "Algorithm",
        category: "complete"
    }
];

export default class PlainDnd extends LightningElement {
    @track tasklist = tasks;
    @track leftTasks = [];
    @track rightTasks = [];
    @track draggingid = "";

    connectedCallback() {
        this.distributeTasks();
    }

    distributeTasks() {
        let curLeftTasks = [];
        let curRightTasks = [];
        this.tasklist.forEach(function(t){
            if(t.category === "wip") {
                curLeftTasks.push(t);
            } else {
                curRightTasks.push(t);
            }
        });

        this.leftTasks = curLeftTasks;
        this.rightTasks = curRightTasks;
    }

    handleDragOver(evt) {
        evt.preventDefault();
    }

    handleListItemDrag(evt) {
        console.log('Dragged id is: ' + evt.detail);
        this.draggingid = evt.detail;
    }

    handleItemDrop(evt) {
        let id = this.draggingid;
        let category = evt.detail;

        let tasks = this.tasklist.filter((task) => {
			if (task.taskid === id) {
			    task.category = category;           
			}              
			return task;       
		});

        this.tasklist = tasks;
        this.distributeTasks();
    }
}