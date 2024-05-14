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
    /// Логика взаимодействия для ScoreTestWindow.xaml
    /// </summary>
    public partial class ScoreTestWindow : Window
    {

        public ScoreTestWindow(Test Test, int IdUser)
        {
            InitializeComponent();

            using (TestDBEntities db = new TestDBEntities())
            {
                scoreLabel.Content = db.TestScore.FirstOrDefault(u => u.IdTest == Test.Id && u.IdUser == IdUser).Score.Number;
            }
        }

        private void closeBtn_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
