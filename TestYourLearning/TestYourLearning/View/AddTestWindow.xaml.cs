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
    /// Логика взаимодействия для AddTestWindow.xaml
    /// </summary>
    public partial class AddTestWindow : Window
    {
        private int idSubject = 0; 
        public AddTestWindow(int IdSubject)
        {
            InitializeComponent();
            idSubject = IdSubject;  
        }


        private void furtherBtn_Click(object sender, RoutedEventArgs e)
        {
            Test newTest = new Test();
            newTest.IdSubject = idSubject;

            int number = 0;

            bool nameL = nameTestTB.Text.Length > 0 && nameTestTB.Text.Trim().Length != 0;
            bool countQL = countTestQuestionTB.Text.Length > 0 && countTestQuestionTB.Text.Trim().Length != 0;

            if (!nameL)
            {
                MessageBox.Show("Введите название теста", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            {
                newTest.Name = nameTestTB.Text;
            }
            if (!countQL)
            {
                MessageBox.Show("Введите количество вопросов (от 1 до 100)", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else
            { 
                // Проверяем, что значение является числом
                if (!int.TryParse(countTestQuestionTB.Text, out number))
                {
                    MessageBox.Show("Введено не число", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
                
                // Проверяем, что число находится в диапазоне от 1 до 100
                else if (number < 1 || number > 100)
                {
                    MessageBox.Show("Число не находится в диапазоне от 1 до 100", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }

            if (newTest.Name != null && number > 0 && number <= 100)
            {
                AddQuestionsWindow addQuestionsWindow = new AddQuestionsWindow(number, newTest);
                this.Close();
                addQuestionsWindow.ShowDialog();
            }
        }
    }
}
