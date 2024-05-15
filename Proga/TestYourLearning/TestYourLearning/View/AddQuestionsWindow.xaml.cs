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
    /// Логика взаимодействия для AddQuestionsWindow.xaml
    /// </summary>
    public partial class AddQuestionsWindow : Window
    {
        private int countQuestion = 0;
        private int currentNumQuestion = 0;
        private int number = 0;
        public AddQuestionsWindow(int CountQuestion, int CurrentNumQuestion)
        {
            InitializeComponent();

            countQuestion = CountQuestion;
            currentNumQuestion = CurrentNumQuestion;

            
        }

        private void furtherBtn_Click(object sender, RoutedEventArgs e)
        {

            if (countQuestion >= currentNumQuestion)
            {
                var newQuestion = new Question();

                bool nameL = nameQuestionTB.Text.Length > 0 && nameQuestionTB.Text.Trim().Length != 0;
                bool countQL = countTestAnswerTB.Text.Length > 0 && countTestAnswerTB.Text.Trim().Length != 0;


                if (!nameL)
                {
                    MessageBox.Show("Введите название вопроса", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    newQuestion.Name = nameQuestionTB.Text;
                }
                if (!countQL)
                {
                    MessageBox.Show("Введите количество ответов (от 1 до 10)", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                else
                {
                    // Проверяем, что значение является числом
                    if (!int.TryParse(countTestAnswerTB.Text, out number))
                    {
                        MessageBox.Show("Введено не число", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    }

                    // Проверяем, что число находится в диапазоне от 1 до 100
                    else if (number < 1 || number > 10)
                    {
                        MessageBox.Show("Число не находится в диапазоне от 1 до 100", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }

                if (newQuestion.Name != null && number > 0 && number <= 10)
                {
                    using (TestDBEntities db = new TestDBEntities())
                    {
                        db.Question.AddOrUpdate(newQuestion);
                        db.SaveChanges();

                        QuestionInTest questionInTest = new QuestionInTest();
                        questionInTest.IdQuestion = db.Question.OrderByDescending(q => q.Id).First().Id;
                        questionInTest.IdTest = db.Test.OrderByDescending(t => t.Id).First().Id;
                        questionInTest.Number = currentNumQuestion;

                        db.QuestionInTest.AddOrUpdate(questionInTest);
                        db.SaveChanges();
                    }
                    AddAnswerWindow addAnswerWindow = new AddAnswerWindow(countQuestion, currentNumQuestion, number);
                    this.Close();
                    addAnswerWindow.ShowDialog();
                }
            }
        }
    }
}
