import UIKit

class HourlyTableViewCell: UITableViewCell {
  
  // MARK: Outlets
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var hourLabel: UILabel!
  @IBOutlet weak var descLabel: UILabel!
  @IBOutlet weak var tempView: UIView!
  @IBOutlet weak var popLabel: UILabel!
  @IBOutlet weak var maxMinLabel: UILabel!
  
  var labels: [UILabel]!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    labels = [tempLabel, hourLabel, descLabel, popLabel]
    //maxMinLabel.transform = CGAffineTransform(rotationAngle: CGFloat(( 90 * Double.pi ) / 180))
  }
}
