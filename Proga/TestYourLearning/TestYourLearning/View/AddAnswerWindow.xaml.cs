using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using TestYourLearning.Model;

namespace TestYourLearning.View
{
    /// <summary>
    /// Логика взаимодействия для AddAnswerWindow.xaml
    /// </summary>
    public partial class AddAnswerWindow : Window
    {
        private int countQuestion = 0;
        private int countAnswer = 0;
        private int currentNumQuestion = 0;
        private List<AnswerOption> options = new List<AnswerOption>();

        public AddAnswerWindow(int CountQuestion, int CurrentNumQuestion, int CountAnswer)
        {
            InitializeComponent();

            countQuestion = CountQuestion;
            currentNumQuestion = CurrentNumQuestion;
            countAnswer = CountAnswer;

            for (int i = 0; i < countAnswer; i++)
            {
                options.Add(new AnswerOption());
            }
            AnswersList.ItemsSource = options;
        }
        public class AnswerOption
        {
            public string AnswerText { get; set; }
            public bool IsCorrect { get; set; }
        }
        private void ReadAnswers()
        {
            foreach (AnswerOption option in options)
            {
                Answer newAnswer = new Answer();
                newAnswer.Name = option.AnswerText;

                using (TestDBEntities db = new TestDBEntities())
                {
                    db.Answer.Add(newAnswer); 
                    db.SaveChanges();

                    AnswerInQuestion answerInQuestion = new AnswerInQuestion();

                    answerInQuestion.IdQuestion = db.Question.OrderByDescending(q => q.Id).First().Id;
                    answerInQuestion.IdAnswer = db.Answer.OrderByDescending(t => t.Id).First().Id;
                    answerInQuestion.Correct = option.IsCorrect;

                    db.AnswerInQuestion.Add(answerInQuestion); 
                    db.SaveChanges();
                }
            }
        }
        private bool ValidateAnswers()
        {
            bool isValid = true;

            foreach (AnswerOption option in options)
            {
                // Проверяем, что текст ответа не пустой
                if (string.IsNullOrWhiteSpace(option.AnswerText))
                {
                    MessageBox.Show("Один из ответов пустой. Пожалуйста, заполните все поля.", "Ошибка валидации", MessageBoxButton.OK, MessageBoxImage.Error);
                    isValid = false;
                    break;
                }

                // Проверяем, что выбран хотя бы один правильный ответ
                if (options.Any(o => o.IsCorrect))
                {
                    continue; 
                }
                else
                {
                    MessageBox.Show("Выберите хотя бы один правильный ответ.", "Ошибка валидации", MessageBoxButton.OK, MessageBoxImage.Error);
                    isValid = false;
                    break; 
                }
            }

            return isValid; 
        }

        private void furtherBtn_Click(object sender, RoutedEventArgs e)
        {
            if (ValidateAnswers())
            {
                ReadAnswers();
                if(countQuestion != currentNumQuestion)
                {
                    AddQuestionsWindow addQuestionsWindow = new AddQuestionsWindow(countQuestion, currentNumQuestion + 1);
                    this.Close();
                    addQuestionsWindow.ShowDialog();
                }
                else
                {
                    this.Close();
                }
            }
        }
    }
}
