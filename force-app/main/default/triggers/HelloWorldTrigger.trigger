trigger HelloWorldTrigger on Account (before insert) {
    System.debug('hello triggers !!!!!');

}