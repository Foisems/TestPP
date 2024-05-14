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
    /// Логика взаимодействия для PassTestWindow.xaml
    /// </summary>
    public partial class PassTestWindow : Window
    {
        private Test test = new Test();
        private int count = 0;
        private List<RadioButtonItem> radioButtons = new List<RadioButtonItem>();
        private int correctAnswer = 0;
        private int idCheckedRadio = 0;
        private int idUser = 0;

        public PassTestWindow(Test Test, int Count, int IdUser)
        {
            InitializeComponent();

            test = Test;
            count = Count;
            idUser = IdUser;

            nameTestTB.Text = "Тест: \"" + test.Name + "\"";
            numberQuestionLabel.Content = "1";

            var firstQuestion = test.QuestionInTest.FirstOrDefault(u => u.IdTest == test.Id).Question;
            string nameFirstQuestion = firstQuestion.Name;

            nameQuestionTB.Text = nameFirstQuestion;

            if(count == 1)
            {
                nextQuestionBtn.Visibility = Visibility.Collapsed;
                exitTestBtn.Visibility = Visibility.Visible;
            }
            else
            {
                nextQuestionBtn.Visibility = Visibility.Visible;
                exitTestBtn.Visibility = Visibility.Collapsed;

            }

            this.DataContext = this;
            var answerInQ = TestDBEntities.GetContext().AnswerInQuestion.Where(u => u.IdQuestion == firstQuestion.Id).ToList();
           
            var answers = TestDBEntities.GetContext().Answer.ToList();

            // Преобразование ответов в список элементов RadioButton
            List<RadioButtonItem> radioButtons = answerInQ
                .Select(a => new RadioButtonItem { Content = a.Answer.Name, IsChecked = false, Id = a.IdAnswer })
                .ToList();
            radioButtons.ForEach(r => r.OnCheckedChanged = (radioButtonItem) =>
            {
                if (radioButtonItem.IsChecked)
                {
                    idCheckedRadio = radioButtonItem.Id;
                }
            });


            itemsControlAnswers.ItemsSource = radioButtons;
        }
        public class RadioButtonItem
        {
            public int Id { get; set; }
            public string Content { get; set; }
            private bool _isChecked;
            public bool IsChecked
            {
                get { return _isChecked; }
                set
                {
                    _isChecked = value;
                    OnCheckedChanged?.Invoke(this);
                }
            }

            // Делегат, который будет вызван при изменении IsChecked
            public Action<RadioButtonItem> OnCheckedChanged { get; set; }
        }
       

        string numCurrentQuest = "";

        // Завершить тест
        private void exitTestBtn_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
       
        // Следующий вопрос
        private void nextQuestionBtn_Click(object sender, RoutedEventArgs e)
        {
            var currentQuest = numberQuestionLabel.Content.ToString();
            int numCurrentQuest = int.Parse(currentQuest);
            int numNextQuest = numCurrentQuest + 1;

            if(idCheckedRadio == 0)
            {
                MessageBox.Show("Выберите вариант ответа", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                if (TestDBEntities.GetContext().AnswerInQuestion.FirstOrDefault(u => idCheckedRadio == u.IdAnswer).Correct)
                {
                    correctAnswer += 1;
                }
                idCheckedRadio = 0;
                for (int i = 2; i <= count; i++)
                {
                    if (i == numNextQuest)
                    {
                        numberQuestionLabel.Content = i.ToString();

                        var nextQuestion = TestDBEntities.GetContext().QuestionInTest.FirstOrDefault(u => u.Number == i).Question;

                        nameQuestionTB.Text = nextQuestion.Name;


                        var answerInQ = TestDBEntities.GetContext().AnswerInQuestion.Where(u => u.IdQuestion == nextQuestion.Id).ToList();
                        var answers = TestDBEntities.GetContext().Answer.ToList();

                        // Преобразование ответов в список элементов RadioButton
                        List<RadioButtonItem> radioButtons = answerInQ
                            .Select(a => new RadioButtonItem { Content = a.Answer.Name, IsChecked = false, Id = a.IdAnswer }).ToList();

                        radioButtons.ForEach(r => r.OnCheckedChanged = (radioButtonItem) =>
                        {
                            if (radioButtonItem.IsChecked)
                            {
                                idCheckedRadio = radioButtonItem.Id;
                            }
                        });

                        itemsControlAnswers.ItemsSource = radioButtons;
                    }
                    if (count == numCurrentQuest + 1)
                    {
                        nextQuestionBtn.Visibility = Visibility.Collapsed;
                        exitTestBtn.Visibility = Visibility.Visible;
                    }
                }
            }
        }

       
        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            var currentQuest = numberQuestionLabel.Content.ToString();
            int numCurrentQuest = int.Parse(currentQuest);

            if (count != numCurrentQuest)
            {
                if (MessageBox.Show("Хотите закончить тест не пройдя его полностью?\nПрогресс будет сброшен!", "Внимание!", MessageBoxButton.YesNo, MessageBoxImage.Information) == MessageBoxResult.No)
                {
                    e.Cancel = true; // отменяем закрытие формы
                }
            }
            else
            {
               
                if (count == numCurrentQuest)
                {
                    if (idCheckedRadio == 0)
                    {
                        MessageBox.Show("Выберите вариант ответа", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                    else
                    {
                        if (TestDBEntities.GetContext().AnswerInQuestion.FirstOrDefault(u => idCheckedRadio == u.IdAnswer).Correct)
                        {
                            correctAnswer += 1;
                        }

                        double score = 5 * correctAnswer / count;
                        var scoreRound = (int)Math.Round(score);
                        if (scoreRound < 2)
                        {
                            scoreRound = 2;
                        }

                        TestScore testScore = new TestScore();
                        testScore.IdUser = idUser;
                        testScore.IdTest = test.Id;
                        testScore.IdScore = TestDBEntities.GetContext().Score.FirstOrDefault(u => u.Number == scoreRound).Id;


                        using (TestDBEntities db = new TestDBEntities())
                        {
                            if(db.TestScore.FirstOrDefault(u => u.IdUser == testScore.IdUser && u.IdTest == testScore.IdTest) != null)
                            {
                                testScore.Id = db.TestScore.FirstOrDefault(u => u.IdUser == testScore.IdUser && u.IdTest == testScore.IdTest).Id;
                            }

                            db.TestScore.AddOrUpdate(testScore);
                            db.SaveChanges();
                        }
                        ScoreTestWindow scoreTestWindow = new ScoreTestWindow(test, idUser);
                        scoreTestWindow.ShowDialog();
                    }
                }
            }
        }
    }
}
