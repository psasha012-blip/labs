function checkNumber(number) {
    if (number > 0) {
        console.log("Число положительное");
    } else if (number < 0) {
        console.log("Число отрицательное");
    } else {
        console.log("Число - ноль");
        return
    }
    if (number % 2 == 0) {
        console.log("Число чётное");
    } else {
        console.log("Число нечётное");
    }
}                                                                                                                                                           

checkNumber(0);

const numbers = [4, 8, 15, 16, 23, 42];
let sum = 0;
let max = numbers[0];
let newNumbers = [];
for (let i = 0; i < numbers.length; i++) {
    sum += numbers[i];
    if (numbers[i] > max) {
        max = numbers[i];
    }
    if (numbers[i] > 10) {
        newNumbers.push(numbers[i]);
    }
    

}
console.log("Сумма", sum);
console.log("Максимальное число в массиве", max);
console.log("Массив из чисел больше 10", newNumbers);

const students = [
    { name: "Иван", grade: 4 },
    { name: "Илья", grade: 5 },
    { name: "Дима", grade: 5 },
    { name: "Сергей", grade: 3 },
    { name: "Игорь", grade: 2 },
];
const minGrade = 2;
for (let i = 0; i < students.length; i++) {
    if (students[i].grade > minGrade) {
        console.log(students[i].name);
    }
}


let summa = 0;
for (let i = 0; i < students.length; i++) {
    summa += students[i].grade;
}
let average = summa / students.length;
console.log("Средняя оценка:", average);


function guessNumber() {
const hiddenNumber = Math.floor(Math.random() * 10) + 1;
const userNumber = Number(prompt("Угадай число от 1 до 10"));

if (userNumber === hiddenNumber) {
    console.log("Угадал");
} else if (userNumber < hiddenNumber) {
    console.log("Заданное число больше");
} else {
    console.log("Заданное число меньше");
}
console.log("Загаданное число", hiddenNumber);
}
guessNumber();