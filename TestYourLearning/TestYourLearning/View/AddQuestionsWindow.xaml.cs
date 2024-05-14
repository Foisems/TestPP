using System;
using System.Collections.Generic;
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
        private Test test = new Test();
        public AddQuestionsWindow(int CountQuestion, Test Test)
        {
            InitializeComponent();

            countQuestion = CountQuestion;
            test = Test;
        }
    }
}
