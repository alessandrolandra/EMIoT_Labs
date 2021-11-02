#!/usr/bin/python2
from jumper.vlab import Vlab
import matplotlib.pyplot as plt

def log_time(number, level):
    time_stamp = v.get_device_time_ms()
    print(time_stamp)
    hist.append(time_stamp)

def main():
    # setup device simulation
    global v
    v = Vlab(working_directory='.', 
        platform='nrf52832',
        print_uart=True)
    v.load('BME280-example.hex')

    # register the callback called on gpio event
    v.on_pin_level_event(log_time)

    # history list
    global hist
    hist = list()

    # run simulation
    print('Run simulation for 4000ms')
    #v.start()
    v.run_for_ms(4000)

    v.stop()
    print('Simulation ended')

    intervals = [j-i for i, j in zip(hist[20:], hist[21:])]
    
    # Plot obtained activity wave
    n_intervals = len(intervals)

    plt.figure()
    t_old = 0.0
    t = 0.0
    val = 0.0
    for i in range(n_intervals):
        t += intervals[i]

        val = float(not val)
        
        plt.vlines(x = t_old, ymin = 0, ymax = 1)
        plt.hlines(y = val, xmin = t_old, xmax = t)
        
        t_old = t
    
    plt.show()

if __name__ == '__main__':
    main()
