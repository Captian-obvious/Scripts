(function(){
var questions=[
    "What is your favorite food?",
    "What is your favorite show (must be within the rules of the server)?",
    "How many digits of pi can you remember?",
    "Does Assyst require further testing?",
    "In your opinion, what was the worst bot response given? (Do not directly say it. Comply with server rules)",
    "Post a random image (must be within server rules), and ask questions about it.",
    "If you could have any superpower, what would it be and why?",
    "What's the most interesting place you've ever visited?",
    "Do you prefer cats, dogs, or neither? Explain your choice!",
    "What's the most creative project you've worked on recently?",
    "What's a skill you’ve always wanted to learn?",
    "If you could live in any fictional universe, which would it be?",
    "What's the best advice you've ever received?",
    "What's your experience with Minecraft?"
];
function chooseRandomQuestion() {
    var theQuestion = questions[Math.floor(Math.random() * questions.length)];
    return theQuestion;
};
return chooseRandomQuestion();
})();